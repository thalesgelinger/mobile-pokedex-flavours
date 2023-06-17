import { Link } from "expo-router";
import { Text, View , StyleSheet} from "react-native";


const Details = () => {
    return <View style={ styles.container}>
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

