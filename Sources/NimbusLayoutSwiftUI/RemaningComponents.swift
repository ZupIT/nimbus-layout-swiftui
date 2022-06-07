//interface WithAccessibility {
//    accessibility?: {
//        label?: string,
//        isHeader?: boolean,
//        // crescer essa lista se julgar necessário, alinhar entre as plataformas
//    }
//}

//export interface FlowRow extends Box {
//
//}

//export interface FlowColumn extends Box {
//
//}

//export interface Stack extends Box {
//
//}

//export interface Lifecycle {
//    onInit?: Action[],
//    children: Component,
//    // onAppear?: Action[], // extra: verificar possibilidade
//}

//export interface Touchable extends WithAccessibility {
//    onPress: Action[],
//    children: Component,
//}

//interface BaseImage extends Size, WithAccessibility {
//    // precisa de alinhamento com o swiftui. Implementar apenas aqueles que forem comuns.
//    scale?: 'crop' | 'fillBounds' | 'fillHeight' | 'fillWidth' | 'fit' | 'inside' | 'none' // default: none
//}

//export interface LocalImage extends BaseImage {
//    id?: string,
//    // url?: string, // do not implement, reserved for web
//}

//export interface RemoteImage extends BaseImage {
//    url: string,
//    placeholder?: string, // id of the local image
//}

//export interface Positioned {
//    alignment?: 'topStart' | 'topEnd' | 'bottomStart' | 'bottomEnd' | 'topCenter' | 'bottomCenter' | 'centerStart' | 'centerEnd' | 'center', // default: topStart
//    x?: double, // sempre da esquerda para a direita; default: 0.
//    y?: double, // sempre de cima para baixo; default: 0.
//    children: Component,
//}

//export interface ScrollView {
//    direction?: 'vertical' | 'horizontal' | 'both', // default: both
//    scrollIndicator?: boolean, //default: true
//    children: Component,
//}

//interface SafeArea {
//    top?: boolean, // default: true
//    bottom?: boolean, // default: true
//    trailing?: boolean, // default: true
//    leading?: boolean, // default: true
//    vertical?: boolean, // default: true
//    horizontal?: boolean, // default: true
//    all?: boolean, // default: true
//}

//export interface Screen {
//    safeArea?: SafeArea,
//    title?: String,
//    showBackButton?: boolean, // default: true
//    // navigationBarItems?: { title: string, image: string }[],
//    children: Component,
//}
