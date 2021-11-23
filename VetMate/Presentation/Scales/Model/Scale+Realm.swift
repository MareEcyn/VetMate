import RealmSwift

class ScaleAnswer: EmbeddedObject {
    @Persisted var index: Int
    @Persisted var text: String
    @Persisted var score: Int

    convenience init(index: Int, text: String, score: Int) {
        self.init()
        self.index = index
        self.text = text
        self.score = score
    }
}

class ScaleQuestion: EmbeddedObject {
    @Persisted var index: Int
    @Persisted var text: String
    @Persisted var answers: List<ScaleAnswer>

    convenience init(index: Int, text: String, answers: [ScaleAnswer]) {
        self.init()
        self.index = index
        self.text = text
        self.answers.append(objectsIn: answers)
    }
}

class Scale: Object, ObjectKeyIdentifiable {
    @Persisted var name: String
    @Persisted var author: String
    @Persisted var questions: List<ScaleQuestion>

    convenience init(name: String, author: String, questions: [ScaleQuestion]) {
        self.init()
        self.name = name
        self.author = author
        self.questions.append(objectsIn: questions)
    }
}
