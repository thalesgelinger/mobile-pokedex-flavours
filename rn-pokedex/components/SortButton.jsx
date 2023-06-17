import { StyleSheet, View } from "react-native"
import Sort from '../images/icons/sort.svg'
import { colors, elevation } from "../theme"


export const SortButton = () => {
    return <View style={[styles.container, elevation.dropShadow[2]]}>
        <Sort width={16} height={16} color={colors.identity.primary} />
    </View>
}

const styles = StyleSheet.create({
    container: {
        backgroundColor: colors.grayscale.white,
        height: 32,
        width: 32,
        borderRadius: 16,
        alignItems: 'center',
        justifyContent: 'center',
    }
})
