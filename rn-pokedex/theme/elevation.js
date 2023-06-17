import { colors } from "./colors";


export const elevation = {
    dropShadow: {
        2: {
            elevation: 2,
            shadowOpacity: 0.2,
            shadowColor: colors.grayscale.dark,
            shadowOffset: {
                width: 1,
                height: 1,
            }
        },
        6: {
            elevation: 6,
            shadowOpacity: 0.2,
            shadowColor: colors.grayscale.dark,
            shadowOffset: {
                width: 3,
                height: 3,
            }
        }
    },
    innerShadow: {
        2: {
            elevation: 1,
            shadowOpacity: 0.2,
            shadowColor: colors.grayscale.dark,
            shadowOffset: {
                width: 0,
                height: 0,
            }
        }
    }
}
