import { useEffect, useState } from "react";
import { Link, useLocalSearchParams } from "expo-router";
import { Text, View, StyleSheet } from "react-native";
import { api } from '../../services/api'


const Details = () => {
    const { id } = useLocalSearchParams();

    const [details, setDetails] = useState(null);

    useEffect(() => {
        api.get(`https://pokeapi.co/api/v2/pokemon/${id}`).then(setDetails)
    }, [])

    console.log({ details})

    return <View style={styles.container}>
        <Link href={"/"}>
            <Text>Details</Text>
        </Link>
    </View>

}

export default Details;

const styles = StyleSheet.create({
    container: {
        alignItems: 'center',
        justifyContent: 'center',
        flex: 1
    }

})

