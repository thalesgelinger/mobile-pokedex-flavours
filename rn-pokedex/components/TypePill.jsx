import { Text, View } from "react-native"
import { colors, typography } from "../theme"

export const TypePill = ({ type }) => {
    const typeTitle = type.charAt(0).toUpperCase() + type.substring(1)

    return <View style={[{
        backgroundColor: colors.pokeType[type],
        paddingHorizontal: 8,
        paddingVertical: 2,
        borderRadius: 10
    }]}>
        <Text style={[typography.header.subtitle3, { color: colors.grayscale.white }]}>{typeTitle}</Text>
    </View>
}

