import { useEffect, useState } from "react";
import { Link, useLocalSearchParams, useRouter } from "expo-router";
import {
    Text,
    View,
    StyleSheet,
    SafeAreaView,
    Image,
    ActivityIndicator,
    Pressable,
    TouchableOpacity
} from "react-native";
import { api } from '../../services/api'
import ArrowBack from '../../images/icons/arrow_back.svg'
import Pokeball from '../../images/icons/pokeball.svg'
import ChevronLeft from '../../images/icons/chevron_left.svg'
import ChevronRight from '../../images/icons/chevron_right.svg'
import Weight from '../../images/icons/weight.svg'
import Height from '../../images/icons/straigthen.svg'
import { colors, typography } from "../../theme";
import { ProgressBar, TypePill } from "../../components";


const Details = () => {
    const { id } = useLocalSearchParams();
    const router = useRouter();

    const [details, setDetails] = useState(null);

    useEffect(() => {
        fetchAndSanitizeDetails()
    }, [])

    const fetchAndSanitizeDetails = async () => {
        const {
            species,
            sprites,
            weight,
            height,
            abilities,
            types,
            stats
        } = await api.get(`https://pokeapi.co/api/v2/pokemon/${id}`)

        const details = {
            name: species.name,
            image: sprites.front_default,
            weight,
            height,
            abilities: abilities.map(({ ability }) => ability.name),
            types: types.map(({ type }) => type.name),
            stats: stats.reduce((acc, { base_stat, stat }) => {
                return {
                    ...acc,
                    [stat.name]: base_stat
                }
            }, {})
        }

        setDetails(details)
    }

    const baseStatsToPercentage = (value) => {
        const statsInPercentage = value * 100 / 255
        return statsInPercentage
    }

    if (!details) {
        return <ActivityIndicator />
    }

    return <SafeAreaView style={[styles.container, { backgroundColor: colors.pokeType[details.types[0]] }]}>
        <Pokeball style={styles.pokeball} width={208} height={208} />
        <View style={styles.header}>
            <TouchableOpacity onPress={router.back} style={styles.back}>
                <ArrowBack color={colors.grayscale.white} />
            </TouchableOpacity>
            <Text style={styles.headerTitle}>{details.name}</Text>
            <Text style={styles.number}>#{id}</Text>
        </View>

        <View style={styles.center}>
            {id > 1 &&
                <TouchableOpacity onPress={() => router.replace(`/details/${Number(id) - 1}`)}>
                    <ChevronLeft color={colors.grayscale.white} />
                </TouchableOpacity>
            }
            <Image
                source={{
                    uri: details.image
                }}
                style={styles.image}
            />
            <TouchableOpacity onPress={() => router.replace(`/details/${Number(id) + 1}`)}>
                <ChevronRight color={colors.grayscale.white} />
            </TouchableOpacity>
        </View>

        <View style={styles.description}>
            <View style={styles.types}>
                {details.types.map((type) =>
                    <TypePill type={type} />
                )}
            </View>
            <Text style={styles.about}>
                About
            </Text>
            <View style={styles.characteristics}>
                <View style={styles.block}>
                    <View style={styles.row}>
                        <Weight color={colors.grayscale.dark} width={24} />
                        <Text>{details.weight}kg</Text>
                    </View>
                    <Text style={styles.titleChar}>Weight</Text>
                </View>
                <View style={styles.block}>
                    <View style={styles.row}>
                        <Height
                            color={colors.grayscale.dark}
                            width={24}
                            style={{ transform: [{ rotate: '90deg' }] }}
                        />
                        <Text>{details.height}m</Text>
                    </View>
                    <Text style={styles.titleChar}>Height</Text>
                </View>
                <View style={styles.block}>
                    <View style={styles.moves}>
                        {details.abilities.map(ability =>
                            <Text style={{ color: colors.grayscale.dark }}>{ability}</Text>
                        )}
                    </View>
                    <Text style={styles.titleChar}>Moves</Text>
                </View>
            </View>

            <Text style={styles.pokeDescription} >
                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc iaculis eros vitae tellus condimentum maximus sit amet in eros.
            </Text>

            <Text style={styles.about}>
                Base Stats
            </Text>
            <View style={styles.stats}>
                <View style={styles.labels}>
                    <Text style={styles.label}>HP</Text>
                    <Text style={styles.label}>ATK</Text>
                    <Text style={styles.label}>DEF</Text>
                    <Text style={styles.label}>SATK</Text>
                    <Text style={styles.label}>SDEF</Text>
                    <Text style={styles.label}>SPD</Text>
                </View>
                <View style={styles.valuesStats}>
                    <View>
                        <Text style={styles.value}>{details.stats["hp"]}</Text>
                        <Text style={styles.value}>{details.stats["attack"]}</Text>
                        <Text style={styles.value}>{details.stats["defense"]}</Text>
                        <Text style={styles.value}>{details.stats["special-attack"]}</Text>
                        <Text style={styles.value}>{details.stats["special-defense"]}</Text>
                        <Text style={styles.value}>{details.stats["speed"]}</Text>
                    </View>
                    <View style={styles.bars}>
                        <ProgressBar
                            percentage={baseStatsToPercentage(details.stats["hp"])}
                            pokeType={details.types[0]}
                        />
                        <ProgressBar
                            percentage={baseStatsToPercentage(details.stats["attack"])}
                            pokeType={details.types[0]}
                        />
                        <ProgressBar
                            percentage={baseStatsToPercentage(details.stats["defense"])}
                            pokeType={details.types[0]}
                        />
                        <ProgressBar
                            percentage={baseStatsToPercentage(details.stats["special-attack"])}
                            pokeType={details.types[0]}
                        />
                        <ProgressBar
                            percentage={baseStatsToPercentage(details.stats["special-defense"])}
                            pokeType={details.types[0]}
                        />
                        <ProgressBar
                            percentage={baseStatsToPercentage(details.stats["hp"])}
                            pokeType={details.types[0]}
                        />
                    </View>
                </View>
            </View>

        </View>
    </SafeAreaView>

}

export default Details;

const styles = StyleSheet.create({
    container: {
        flex: 1,
        position: 'relative'
    },
    header: {
        flexDirection: 'row',
        alignItems: 'center',
        paddingHorizontal: 30
    },
    headerTitle: {
        ...typography.header.headline,
        flex: 1,
        color: colors.grayscale.white,
        marginLeft: 16
    }, number: {
        ...typography.header.subtitle2,
        color: colors.grayscale.white
    },
    pokeball: {
        color: colors.grayscale.white,
        opacity: 0.3,
        position: 'absolute',
        right: 10,
        top: 40,
    },
    center: {
        flexDirection: 'row',
        alignItems: 'center',
        height: 200,
        top: 20,
        zIndex: 10
    },
    image: {
        width: 300,
        height: 300,
        flex: 1,
    },
    description: {
        height: '100%',
        backgroundColor: colors.grayscale.white,
        margin: 4,
        borderRadius: 8
    },
    types: {
        marginTop: 40,
        flexDirection: 'row',
        justifyContent: 'center',
        gap: 10
    },
    about: {
        ...typography.header.subtitle1,
        color: colors.grayscale.medium,
        textAlign: 'center',
        marginVertical: 16
    },
    characteristics: {
        backgroundColor: colors.grayscale.medium,
        flexDirection: 'row',
        gap: 1,
        marginHorizontal: 20
    },
    block: {
        flex: 1,
        backgroundColor: colors.grayscale.white,
        alignItems: 'center'
    },
    pokeDescription: {
        marginHorizontal: 20,
        marginVertical: 30,
        color: colors.grayscale.dark
    },
    stats: {
        flexDirection: 'row',
        gap: 2,
        backgroundColor: colors.grayscale.light,
        marginHorizontal: 8
    },
    labels: {
        backgroundColor: colors.grayscale.white,
    },
    label: {
        textAlign: 'right',
        color: colors.grayscale.medium,
        marginHorizontal: 8,
        marginVertical: 4
    },
    valuesStats: {
        flex: 1,
        backgroundColor: colors.grayscale.white,
        flexDirection: 'row'
    },
    value: {
        marginHorizontal: 8,
        marginVertical: 4
    },
    row: {
        flexDirection: 'row',
        alignItems: 'center',
        gap: 8
    },
    moves: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center'
    },
    titleChar: {
        color: colors.grayscale.medium,
        ...typography.body.caption
    },
    bars: {
        flex: 1,
    },
    back: {
        height: 50,
        width: 50,
    }
})


