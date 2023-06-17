

export const api = {
    async get(endpoint) {
        const raw = await fetch(endpoint)
        const response = await raw.json();
        return response;
    }
}
