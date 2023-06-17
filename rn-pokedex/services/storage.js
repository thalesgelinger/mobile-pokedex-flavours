import AsyncStorage from "@react-native-async-storage/async-storage"


export const storage = {
    async get(key) {
        const response = await AsyncStorage.getItem(key);
        return JSON.parse(response);
    },
    async set(key, value) {
        await AsyncStorage.setItem(key, JSON.stringify(value));
    },
    async has(key) {
        const allKeys =  await AsyncStorage.getAllKeys()
        return allKeys.includes(key);
    }
}
