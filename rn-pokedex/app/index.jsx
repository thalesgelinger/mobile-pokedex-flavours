import { useEffect, useState } from 'react'
import { Text, View, StyleSheet, SafeAreaView, FlatList } from "react-native";
import { colors, typography } from "../theme";
import { SearchBar, SortButton, Card } from "../components";
import Pokeball from "../images/icons/pokeball.svg"
import { api } from '../services/api'

const BASE_URL = "https://pokeapi.co/api/v2/"

const SearchPage = () => {

    const [data, setData] = useState([]);
    const [searchTerm, setSearchTerm] = useState('')

    const filteredData = [...data].filter((pokemon) => {
        return pokemon.name.includes(searchTerm.toLowerCase())
            || pokemon.number == searchTerm
    })

    useEffect(() => {
        fetchPokemons();
    }, [])


    const fetchPokemons = async () => {
        const { results } = await api.get(BASE_URL + `pokemon?limit=${data.length + 21}&offset=${data.length}`);
        const pokedata = await Promise.all(results.map(async ({ name, url }, index) => {
            const details = await api.get(url);
            return {
                name,
                number: data.length + index + 1,
                img: details.sprites.front_default
            }
        }))

        setData((prevData) => [prevData, pokedata].flat())
    }

    return <SafeAreaView style={styles.container}>
        <View style={styles.header}>
            <View style={styles.headerTitle}>
                <Pokeball width={24} height={24} color={colors.grayscale.white} />
                <Text style={styles.title}>Pokédex</Text>
            </View>

            <View style={styles.searchHeader}>
                <View style={styles.searchBar}>
                    <SearchBar searchTerm={searchTerm} onChangeSearchTerm={setSearchTerm} />
                </View>
                <SortButton />
            </View>

        </View>

        <FlatList
            style={styles.listContainer}
            showsVerticalScrollIndicator={false}
            data={filteredData}
            renderItem={({ item }) => <Card
                img={item.img}
                name={item.name}
                number={item.number}
            />}
            keyExtractor={(item) => item.name}
            numColumns={3}
            onEndReached={fetchPokemons}
            onEndReachedThreshold={3}
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

