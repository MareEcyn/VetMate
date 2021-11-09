import RealmSwift

class ScaleQuestion: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var text: String
    @Persisted var score: Int

    convenience init(text: String, score: Int) {
        self.init()
        self.text = text
        self.score = score
    }
}

class ScaleSection: EmbeddedObject, ObjectKeyIdentifiable {
    @Persisted var title: String
    @Persisted var questions: List<ScaleQuestion>

    convenience init(title: String, questions: [ScaleQuestion]) {
        self.init()
        self.title = title
        self.questions.append(objectsIn: questions)
    }
}

class Scale: Object, ObjectKeyIdentifiable {
    @Persisted var name: String
    @Persisted var author: String
    @Persisted var sections: List<ScaleSection>

    convenience init(name: String, author: String, sections: [ScaleSection]) {
        self.init()
        self.name = name
        self.author = author
        self.sections.append(objectsIn: sections)
    }
}
