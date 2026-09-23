pragma Singleton

import Quickshell
import QtQml

Singleton {
    property ObjectModel entries: DesktopEntries.applications
    property ListModel filteredEntries: ListModel {}
    signal launched

    function matcher(input: string, lookupWord: string): var {
        const CONSECUTIVE_PENALTY = 2;
        const WORD_START_PENALTY = 3;
        const SEPARATORS = ["-", " ", "_"];

        let searchIndex = 0;
        let lookupIndex = 0;
        let previousMatchIndex = -2;
        let score = 0;
        let matched = false;

        while (searchIndex < input.length && lookupIndex < lookupWord.length) {
            const currentSearch = input[searchIndex];
            const currentLookup = lookupWord[lookupIndex];

            if (currentSearch.toLowerCase() === currentLookup.toLowerCase()) {
                matched = true;
                score += lookupIndex;
                searchIndex++;

                if (previousMatchIndex >= 0 && lookupIndex - 1 === previousMatchIndex)
                    score -= CONSECUTIVE_PENALTY;

                if (lookupIndex === 0)
                    score -= WORD_START_PENALTY;
                else {
                    const previousLookupWord = lookupWord[lookupIndex - 1];
                    const isSeparator = SEPARATORS.includes(previousLookupWord);
                    if (isSeparator)
                        score -= WORD_START_PENALTY;
                    else if (currentLookup.toUpperCase() === currentLookup && previousLookupWord === previousLookupWord.toLowerCase())
                        score -= WORD_START_PENALTY;
                }

                previousMatchIndex = lookupIndex;
            }

            lookupIndex++;
        }

        return {
            matched,
            score
        };
    }

    function filter(query: string) {
        filteredEntries.clear();

        const q = query.trim();
        if (!q)
            return;

        const result = [];
        for (const entry of entries.values) {
            if (entry.noDisplay)
                continue;

            const {
                matched,
                score
            } = matcher(q, entry.name);
            if (!matched)
                continue;

            result.push({
                name: entry.name,
                icon: entry.icon,
                description: entry.genericName || entry.comment,
                entryId: entry.id,
                score
            });
        }

        result.sort((a, b) => a.score - b.score);

        for (const res of result)
            filteredEntries.append(res);
    }

    function launch(entryId: string) {
        const id = entryId.endsWith(".desktop") ? entryId : `${entryId}.desktop`;
        Quickshell.execDetached(["app2unit", id]);
        launched();
    }
}
