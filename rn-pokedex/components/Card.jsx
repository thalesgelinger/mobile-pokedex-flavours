import { View, Text, StyleSheet, Dimensions, Image } from 'react-native'
import { colors, elevation, typography } from '../theme'

export const Card = ({img, name, number}) => {
    return <View style={styles.container}>
        <View style={styles.card}>
            <Text style={styles.number}>#{number}</Text>
            <Image
                source={{
                    uri: img
                }}
                style={styles.image}
            />
            <View style={styles.background}>
                <Text style={styles.name}>{name}</Text>
            </View>
        </View>
    </View>
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
        height: Dimensions.get('window').width / 3,
        overflow: 'hidden'
    },
    card: {
        ...elevation.dropShadow[6],
        height: 108,
        width: 104,
        backgroundColor: colors.grayscale.white,
        position: 'relative',
        borderRadius: 8,
        alignItems: 'center',
        justifyContent: 'center'
    },
    background: {
        width: '100%',
        height: 44,
        borderRadius: 8,
        backgroundColor: colors.grayscale.background,
        position: 'absolute',
        bottom: 0,
        alignItems: 'center',
        justifyContent: 'flex-end'
    },
    name: {
        ...typography.body.body3,
        color: colors.grayscale.dark,
        marginBottom: 4
    },
    number: {
        textAlign: 'right',
        ...typography.body.caption,
        color: colors.grayscale.medium,
        marginTop: 4,
        marginRight: 8,
        position: 'absolute',
        top: 0,
        right: 0
    },
    image: {
        width: 150,
        height: 150,
        zIndex: 10,
    }
})

