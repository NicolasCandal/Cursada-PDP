class ave {
    var energia = 5

    var velocidad = 20

    method volar(metros) {
        energia -= metros/velocidad
    }

}

const pepita = new ave(energia = 200, velocidad = 10)

const coco = new ave()