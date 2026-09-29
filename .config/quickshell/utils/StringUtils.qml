pragma Singleton

import Quickshell

Singleton {
    function capitalize(input: string): string {
        return input.charAt(0).toUpperCase() + input.slice(1);
    }

    function startCase(input: string): string {
        const strings = input.replace(/[-_]/g, " ").replace(/([A-Z][a-z])/g, " $1").replace(/(\d)/g, " $1").split(/\s+/);

        return strings.map(capitalize).join(" ");
    }
}
