import 'package:flutter/material.dart';

var primarySwatch = MaterialColor(
  const Color(0xF4089556).value,
  const <int, Color>{
    50: Color(0xFFE8F5E9),
    100: Color(0xFFC8E6C9),
    200: Color(0xFFA5D6A7),
    300: Color(0xFF81C784),
    400: Color(0xFF66BB6A),
    500: Color(0xFF2E7D32),
    600: Color(0xFF43A047),
    700: Color(0xFF388E3C),
    800: Color(0xF4089556),
    900: Color(0xFF1B5E20),
  },
);

var metricsNames = [
  'Mantenibilidad',
  'Facilidad de uso',
  'Portabilidad',
  'Fiabilidad',
  'Consumo de energía',
];

var metrics = <Map<String, Map<int, List>>>[
  <String, Map<int, List>>{
    'Documentación del software': <int, List>{
      0: ['No presenta documentación', true],
      1: ['Presenta una documentación pobre', false],
      2: ['Presenta una documentación adecuada', false],
    },
    'Simplicidad del código': <int, List>{
      0: ['Métodos sin comentar y variables no entendibles', true],
      1: ['Métodos y variables poco entendibles', false],
      2: ['Métodos y variables entendibles', false],
    },
    'Lenguaje de programación usado': <int, List>{
      0: ['C++, Ensamblador, Lisp', true],
      1: ['Prolog, C', false],
      2: ['Python, Java', false],
    },
  },
  <String, Map<int, List>>{
    'Accesibilidad': <int, List>{
      0: ['No se tiene en cuenta', true],
      1: [
        'Presenta un diseño accesible para la mayoría del público o clientes',
        false
      ],
      2: [
        'Además de su interfaz predeterminada, tiene ajustes que hacen de la aplicación más accesible y así llegar a todos con la máxima comodidad',
        false
      ],
    },
    'Interfaz gráfica': <int, List>{
      0: ['Presenta una interfaz gráfica compleja y poco intuitiva', true],
      1: [
        'Presenta una interfaz gráfica con opciones o ventanas poco ordenadas',
        false
      ],
      2: ['Su interfaz gráfica es sencilla, intuitiva y fácil de usar', false],
    },
    'Diseño minimalista': <int, List>{
      0: [
        'Presenta un diseño atiborrado de opciones, colores que dificultan la lectura y la información que brinda no es concisa',
        true
      ],
      1: [
        'Presenta un diseño cómodo pero el acceso a las distintas ventanas puede ser tedioso o poco intuitivo para su acceso',
        false
      ],
      2: [
        'Se opta por un diseño con colores agradables para la lectura, una buena organización y fácil acceso a las distintas ventanas',
        false
      ],
    },
  },
  <String, Map<int, List>>{
    'Cambio de hardware o software': <int, List>{
      0: [
        'No se tiene en cuenta el cambio de software o hardware que puede hacer la empresa o cliente que va a consumir el software',
        true
      ],
      1: [
        'Se desarrolla el software con compatibilidad para una actualización del sistema operativo o incluso una versión anterior',
        false
      ],
      2: [
        'Se tiene en cuenta los cambios de hardware y de software para que, si en el futuro se produce un cambio de estos, el desempeño del software no se vea afectado',
        false
      ],
    },
    'Facilidad de instalación': <int, List>{
      0: [
        'El proceso de instalación es engorroso, al punto de no poder ser instalado por cualquiera persona',
        true
      ],
      1: [
        'Puede ser instalado por cualquier usuario, pero presenta un nivel de complejidad elevado',
        false
      ],
      2: [
        'Presenta un proceso de instalación sencillo, capaz de ser instalado por cualquier usuario',
        false
      ],
    },
    'Adaptación a distintos sistemas': <int, List>{
      0: [
        'No posee la capacidad de adaptarse a otros sistemas operativos ni a versiones distintas al sistema para el cual fue desarrollado',
        true
      ],
      1: [
        'Se necesita un proceso complejo y una alta comprensión del código para ser llevado a un sistema diferente',
        false
      ],
      2: [
        'Presenta gran facilidad para ser llevado de un sistema operativo a otro o ser adaptado a versiones distintas del sistema',
        false
      ],
    },
  },
  <String, Map<int, List>>{
    'Estimaciones poco realistas': <int, List>{
      0: [
        'Realizar estimaciones imposibles de lograr en el tiempo de entrega del software',
        true
      ],
      1: [
        'Realizar estimaciones que, aunque halla posibilidad de lograrse por parte del equipo, comprometan directamente la fecha de entrega del software acordada previamente',
        false
      ],
      2: [
        'Realizar las estimaciones, en cuanto a requerimientos, de forma tal que se puedan lograr por parte del equipo de programación sin ningún problema ni contratiempo',
        false
      ],
    },
    'Planificar bien el tiempo, recursos y esfuerzos': <int, List>{
      0: [
        'Desaprovechar el tiempo y los horarios programados para el desarrollo del software y los recursos que están a la disposición',
        true
      ],
      1: [
        'No tener un buen manejo del tiempo necesario para el desarrollo del producto o gastar recursos de forma innecesaria',
        false
      ],
      2: [
        'Aprovechar al máximo el tiempo de trabajo planificado y usar de forma eficaz los recursos que están a disposición',
        false
      ],
    },
    'Aprovechar los recursos del sistema y conocer limitaciones y restricciones del mismo':
        <int, List>{
      0: [
        'No tener idea del funcionamiento o las características del sistema para el cual va a ser desarrollado el software',
        true
      ],
      1: [
        'Conocer vagamente el sistema en el cual va a ser implementado el software, sin conocer completamente sus limitaciones y características',
        false
      ],
      2: [
        'Conocer el sistema en el cual va a ser desplegado el software para aprovechar los recursos del mismo, así como sus limitaciones',
        false
      ],
    },
  },
  <String, Map<int, List>>{
    'Aprovechamiento energético en la etapa del desarrollo': <int, List>{
      0: [
        'No se aprovecha la luz natural, se usan luminarias que suponen un gasto energético elevado y no se ahorra energía apagando los equipos encendidos innecesariamente',
        true
      ],
      1: [
        'No se utiliza iluminación natural o se gasta más energía de la necesaria por parte de los equipos electrónicos usados',
        false
      ],
      2: [
        'Se utiliza la luz natural en lugar de la artificial, se cambian las lámparas o bombillas de alto consumo y se utilizan solo los equipos necesarios',
        false
      ],
    },
    'Ahorro energético del software': <int, List>{
      0: [
        'No optimizar el código del programa, tener el programa funcionando siempre de forma innecesaria, aunque no se esté utilizando en primer plano por el usuario',
        true
      ],
      1: [
        'Hacer optimizaciones pequeñas y no implementar modos de funcionamiento dedicados al ahorro de energía',
        false
      ],
      2: [
        'Tener en cuenta que el código del software condiciona el uso del hardware, usar líneas de código sencillas e implementar un modo de ahorro de energía, si fuese necesario, para que el programa no esté funcionando permanentemente',
        false
      ],
    },
  },
];

var clasifications = [
  <int, String>{
    0: 'No Sostenible',
    1: 'No Sostenible',
    2: 'Poco Sostenible',
    3: 'Poco Sostenible',
    4: 'Sostenible',
    5: 'Sostenible',
    6: 'Sostenible',
  },
  <int, String>{
    0: 'No Sostenible',
    1: 'No Sostenible',
    2: 'Poco Sostenible',
    3: 'Poco Sostenible',
    4: 'Sostenible',
    5: 'Sostenible',
    6: 'Sostenible',
  },
  <int, String>{
    0: 'No Sostenible',
    1: 'No Sostenible',
    2: 'Poco Sostenible',
    3: 'Poco Sostenible',
    4: 'Sostenible',
    5: 'Sostenible',
    6: 'Sostenible',
  },
  <int, String>{
    0: 'No Sostenible',
    1: 'No Sostenible',
    2: 'Poco Sostenible',
    3: 'Poco Sostenible',
    4: 'Sostenible',
    5: 'Sostenible',
    6: 'Sostenible',
  },
  <int, String>{
    0: 'No Sostenible',
    1: 'Poco Sostenible',
    2: 'Poco Sostenible',
    3: 'Sostenible',
    4: 'Sostenible',
  },
];

Map<String, Color> clasificationColor = {
  'Sostenible': Colors.green,
  'Poco Sostenible': Colors.orange,
  'No Sostenible': Colors.red
};
