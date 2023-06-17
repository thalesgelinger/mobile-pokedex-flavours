import { storage } from "./storage";


export const api = {
    async get(endpoint) {
        if (await storage.has(endpoint)) {
            return await storage.get(endpoint)
        }
        const raw = await fetch(endpoint)
        const response = await raw.json();
        await storage.set(endpoint, response)
        return response;
    }
}
