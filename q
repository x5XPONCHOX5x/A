import Foundation

struct Quiz {
    var preguntas: [String]
    var opciones: [[String]]
    var personajes: [String:String]
}
//Funcion para realizar el cuestionario
func conductQuiz(quiz:Quiz){
    var resUsuario: [Int]=[]
    
    print("Te gustaria saber que personaje eres?")
    print("Selecciona una respuesta por pregunta: \n")
    
    for i in 0..<quiz.preguntas.count {
        print("\(quiz.preguntas[i])")
        
        //Mostrar opciones disponibles
        for (index, opciones) in quiz.opciones[i].enumerated(){
            print("\(index + 1). \(opciones)")
        }
        //Pedir respuestas al usuario y validarla
        var seleccionarOpcion = 0
        var vInput = false
        
        while !vInput {
            print("Ingresa el numero que corresponda a tu seleccion (1-\(quiz.opciones[i].count)): ", terminator: "")
            if let input = readLine(), let choice = Int(input), (1...quiz.opciones[i].count).contains(choice){
                seleccionarOpcion = choice
                vInput = true
            } else {
                print("Respuesta invalida. Ingresa un numero valido.")
            }
        }
        // Guardar la respuesta del usuario
        resUsuario.append(seleccionarOpcion - 1)
        print("")
    }
    // Mostrar resultado final
    let resPersonaje = determineResult(answers: resUsuario, quiz: quiz)
    if let desPersonaje = quiz.personajes[resPersonaje] {
        print("Eres \(desPersonaje)")
    } else {
        print("Aun no se encuentra tu personaje.")
    }
}
//Funcion para encontrar el personaje basado en las respuestas del usuario.
func determineResult(answers:[Int], quiz: Quiz) -> String{
    //Aqui se implementa la logica para comparar respuestas y determinar el personaje
    let preguntasTotales = quiz.preguntas.count
    var puntajePersonajes: [String:Int] = [:]
    for (personajes, _) in quiz.personajes {
        puntajePersonajes[personajes] = 0
    }
    for i in 0..<preguntasTotales {
        let resUsuarioIndex = answers[i]
        for (personajes, correctAnswer) in quiz.personajes {
            let correctAnswerIndex = Int(String(correctAnswer[correctAnswer.index(correctAnswer.startIndex, offsetBy: i)]))!
            if resUsuarioIndex == correctAnswerIndex {
                puntajePersonajes[personajes]! += 1
            }
        }
    }
    var maxScore = 0
    var resPersonajes = ""
    
    for (personaje, score) in puntajePersonajes {
        if score > maxScore {
            maxScore = score
            resPersonajes = personaje
        }
    }
    return resPersonajes
}
// Definir las preguntas, opciones y personajes con sus respuestas modelo
let preguntas = [
    "Que color prefieres?",
    "Cual es tu comida favorita?",
    "Que actividad disfrutas mas?",
    "Cual es tu estacion preferida?",
    "Cual es tu pelicula favorita?",
]

let opciones = [
    ["Rojo", "Azul", "Verde", "Amarillo"],
    ["Pizza", "Hamburguesa", "Sushi", "Ensalada"],
    ["Leer","Correr","Ver peliculas", "Viajar"],
    ["Primavera", "Verano", "Otono", "Invierno"],
    ["Comedia", "Accion", "Romance", "Ciencia ficcion"]
]

let personajes = [
    "Personaje A": "Descripcion del personaje A",
    "Personaje B": "Descripcion del personaje b",
    "Personaje C": "Descripcion del personaje C",
    "Personaje D": "Descripcion del personaje D"
]
let quiz = Quiz(preguntas: preguntas, opciones: opciones, personajes: personajes)
// Indicar el cuestionario
conductQuiz(quiz: quiz)
