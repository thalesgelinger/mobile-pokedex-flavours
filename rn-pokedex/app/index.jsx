import { useEffect, useState } from 'react'
import { Link } from "expo-router";
import { Text, View, StyleSheet, SafeAreaView, FlatList } from "react-native";
import { colors, typography, elevation } from "../theme";
import { TypePill, SearchBar, SortButton, Card } from "../components";
import Pokeball from "../images/icons/pokeball.svg"

const BASE_URL = "https://pokeapi.co/api/v2/"

const SearchPage = () => {

    const [data, setData] = useState([]);

    useEffect(() => {
        fetchPokemons();
    }, [])

    const get = async (endpoint) => {
        const raw = await fetch(endpoint)
        const response = await raw.json();
        return response;
    }

    const fetchPokemons = async () => {
        const { results } = await get(BASE_URL + "pokemon?limit=12&offset=0");
        console.log({ results })
        const pokedata = await Promise.all(results.map(async ({ name, url }, index) => {
            const details = await get(url);
            return {
                name,
                number: index + 1,
                img: details.sprites.front_default
            }
        }))

        setData(pokedata)
    }

    return <SafeAreaView style={styles.container}>
        <View style={styles.header}>
            <View style={styles.headerTitle}>
                <Pokeball width={24} height={24} color={colors.grayscale.white} />
                <Text style={styles.title}>Pokédex</Text>
            </View>

            <View style={styles.searchHeader}>
                <View style={styles.searchBar}>
                    <SearchBar />
                </View>
                <SortButton />
            </View>

        </View>

        <FlatList
            style={styles.listContainer}
            showsVerticalScrollIndicator={false}
            data={data}
            renderItem={({ item }) => <Card img={item.img} name={ item.name} number={ item.number}/>}
            keyExtractor={(item) => item.toString()}
            numColumns={3}
        />
    </SafeAreaView>
}

export default SearchPage;

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: colors.identity.primary
    },
    header: {
        paddingHorizontal: 20,
        paddingTop: 10

    },
    headerTitle: {
        flexDirection: 'row',
        alignItems: 'center',
    },
    searchBar: {
        flex: 1,
        marginRight: 10,
    },
    title: {
        marginLeft: 20,
        ...typography.header.headline,
        color: colors.grayscale.white
    },
    searchHeader: {
        flexDirection: 'row',
        marginVertical: 10
    },
    listContainer: {
        marginHorizontal: 4,
        marginVertical: 4,
        backgroundColor: colors.grayscale.white,
        borderRadius: 16
    },
})

