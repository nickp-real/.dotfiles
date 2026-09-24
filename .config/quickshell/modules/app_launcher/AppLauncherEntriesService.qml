pragma Singleton

import Quickshell
import QtQml

Singleton {
    property ObjectModel entries: DesktopEntries.applications
    property ListModel filteredEntries: ListModel {}
    property bool hasResult: false
    signal launched

    function isWordStart(lookupWord: string, index: int, SEPARATORS: list<string>): bool {
        return index === 0 || SEPARATORS.includes(lookupWord[index - 1]) || lookupWord[index].toUpperCase() === lookupWord[index] && lookupWord[index - 1] === lookupWord[index - 1].toLowerCase();
    }

    function matcher(input: string, lookupWord: string): var {
        const CONSECUTIVE_PENALTY = 2;
        const WORD_START_PENALTY = 3;
        const SEPARATORS = ["-", " ", "_"];

        let searchIndex = 0;
        let lookupIndex = 0;
        let previousMatchIndex = -2;
        let score = 0;
        let anchored = false;

        while (searchIndex < input.length && lookupIndex < lookupWord.length) {
            const currentSearch = input[searchIndex];
            const currentLookup = lookupWord[lookupIndex];

            if (currentSearch.toLowerCase() === currentLookup.toLowerCase()) {
                const isAnchor = isWordStart(lookupWord, lookupIndex, SEPARATORS) || lookupIndex - 1 === previousMatchIndex;
                if (isAnchor)
                    anchored = true;
                score += lookupIndex;
                searchIndex++;

                if (previousMatchIndex >= 0 && lookupIndex - 1 === previousMatchIndex)
                    score -= CONSECUTIVE_PENALTY;

                if (isWordStart(lookupWord, lookupIndex, SEPARATORS))
                    score -= WORD_START_PENALTY;

                previousMatchIndex = lookupIndex;
            }

            lookupIndex++;
        }

        return {
            matched: searchIndex === input.length && anchored,
            score
        };
    }

    function bestScore(q: string, entry: DesktopEntry): var { // int | null
        const fields = [entry.name, entry.genericName];
        let best = null;

        for (const f of fields) {
            if (!f)
                continue;
            const {
                matched,
                score
            } = matcher(q, f);

            if (matched)
                best = best === null ? score : Math.min(best, score);
        }

        return best;
    }

    function filter(query: string) {
        filteredEntries.clear();

        const q = query.trim();
        if (!q) {
            hasResult = false;
            return;
        }

        const result = [];
        for (const entry of entries.values) {
            if (entry.noDisplay)
                continue;

            const score = bestScore(q, entry);
            if (score === null)
                continue;

            result.push({
                name: entry.name,
                icon: entry.icon,
                description: entry.genericName || entry.comment,
                entryId: entry.id,
                score
            });
        }

        result.sort((a, b) => a.score - b.score || (a.name < b.name ? -1 : a.name > b.name ? 1 : 0));

        for (const res of result)
            filteredEntries.append(res);

        hasResult = result.length > 0;
    }

    function launch(entryId: string) {
        const id = entryId.endsWith(".desktop") ? entryId : `${entryId}.desktop`;
        Quickshell.execDetached(["app2unit", id]);
        launched();
    }

    function clear() {
        filteredEntries.clear();
        hasResult = false;
    }
}
