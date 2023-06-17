import { StyleSheet, TextInput, View } from "react-native"
import Search from '../images/icons/search.svg'
import { colors, elevation, typography } from "../theme"


export const SearchBar = () => {
    return <View style={styles.container}>
        <View style={styles.iconContainer}>
            <Search width={20} height={20} color={colors.identity.primary} />
        </View>
        <TextInput
            style={styles.input}
            placeholder="Search" 
        />
    </View>
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        height: 32,
        backgroundColor: colors.grayscale.white,
        position: 'relative',
        borderRadius: 16,
        justifyContent: 'center',
    },
    iconContainer: {
        position: 'absolute',
        top: 6,
        left: 12,
    },
    input: {
        paddingLeft: 36,
        ...typography.body.body3,
        lineHeight: 0
    }
})

