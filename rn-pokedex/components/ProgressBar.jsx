import { StyleSheet, View } from "react-native"
import { colors } from "../theme"


export const ProgressBar = ({ percentage, pokeType }) => {
    return <View style={[styles.bar, {
        backgroundColor: colors.grayscale.medium,
    }]}>
        <View style={[
            styles.progress,
            {
                width: `${percentage}%`,
                backgroundColor: colors.pokeType[pokeType]
            }
        ]}
        />
    </View>
}

const styles = StyleSheet.create({
    bar: {
        height: 4,
        width: '100%',
        marginVertical: 10
    },
    progress: {
        height: "100%",
    },
})
