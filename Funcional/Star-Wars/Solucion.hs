module Solucion where
import Text.Show.Functions()

type Poder = Nave -> Nave
momento :: Poder
momento unaNave = unaNave

data Nave = UnaNave {
    nombre :: String,
    durabilidad :: Int,
    escudos :: Int,
    ataque :: Int,
    poder :: Poder
}  deriving (Show)

mejorarAtaque :: Int -> Poder
mejorarAtaque mejora unaNave = unaNave {ataque = ataque unaNave + mejora} 

mejorarDurabilidad :: Int -> Poder
mejorarDurabilidad mejora unaNave = unaNave {durabilidad = durabilidad unaNave + mejora}

mejorarEscudos :: Int -> Poder 
mejorarEscudos mejora unaNave = unaNave {escudos = escudos unaNave + mejora}

cambiarDurabilidad :: Int -> Poder
cambiarDurabilidad cambio unaNave =unaNave {durabilidad = cambio}

verDurabilidad :: Nave -> Int
verDurabilidad = durabilidad

resta :: Int -> Int -> Int
resta a b = max 0 (a-b)

recibirAtaque :: Int -> Nave -> Nave
recibirAtaque golpe unaNave 
  | resta (escudos unaNave) golpe == 0 = (cambiarDurabilidad . resta (durabilidad unaNave)) (golpe - escudos unaNave) unaNave
  | otherwise = unaNave

-- 1. Modelar las naves espaciales mencionadas y agregar una nueva nave, con un poder especial sutilmente diferente a alguna de las anteriores, en el que se aproveche las otras implementaciones.

fighter :: Nave
fighter = UnaNave "TIE Fighter" 200 100 50 movimientoTurbo

movimientoTurbo :: Poder
movimientoTurbo = mejorarAtaque 25 

wing :: Nave
wing = UnaNave "Wing" 300 150 100 reparaciondeEmergencia

reparaciondeEmergencia :: Poder
reparaciondeEmergencia = mejorarDurabilidad 50 . mejorarAtaque (-25) 

darthVader :: Nave
darthVader = UnaNave "Darth Vader" 500 300 200 movimientoSuperTurbo

movimientoSuperTurbo :: Poder
movimientoSuperTurbo = mejorarDurabilidad (-45) . movimientoTurbo . movimientoTurbo . movimientoTurbo

falcon :: Nave
falcon = UnaNave "Millennium Falcon" 1000 500 50 reparacionPlus

reparacionPlus :: Poder
reparacionPlus = reparaciondeEmergencia . mejorarEscudos 100

kwid :: Nave
kwid = UnaNave "Renno Kwid" 650 200 50 todoNada

todoNada :: Poder
todoNada = mejorarAtaque 1500 . cambiarDurabilidad 25

-- 2. Calcular la durabilidad total de una flota, formada por un conjunto de naves, que es la suma de la durabilidad de todas las naves que la integran.

durabilidadTotal :: [Nave] -> Int
durabilidadTotal = sum.map verDurabilidad  

{- 3. Saber cómo queda una nave luego de ser atacada por otra. 
Cuando ocurre un ataque ambas naves primero activan su poder especial y luego la nave atacada reduce su durabilidad según el daño recibido, 
que es la diferencia entre el ataque de la atacante y el escudo de la atacada. (si el escudo es superior al ataque, la nave atacada no es afectada). 
La durabilidad, el escudo y el ataque nunca pueden ser negativos, a lo sumo 0. -}

combate :: Nave -> Nave -> Nave
combate atacante atacada = recibirAtaque (ataque (poder atacante atacante))  (poder atacada atacada)

-- 4. Averiguar si una nave está fuera de combate, lo que se obtiene cuando su durabilidad llegó a 0.

type Estrategia = (Nave -> Bool)

fueraDeCombate :: Nave -> Bool
fueraDeCombate unaNave = durabilidad unaNave == 0

{- 5. Averiguar cómo queda una flota enemiga luego de realizar una misión sorpresa con una nave siguiendo una estrategia. 
Una estrategia es una condición por la cual la nave atacante decide atacar o no una cierta nave de la flota. 
Por lo tanto la misión sorpresa de una nave hacia una flota significa atacar todas aquellas naves de la flota que la estrategia determine que conviene atacar. 
Algunas estrategias que existen, y que deben estar reflejadas en la solución, son:-}


ataqueAFlota :: Estrategia -> Nave -> [Nave] -> [Nave]
ataqueAFlota = realizarElAtaque 

realizarElAtaque :: Estrategia -> Nave -> [Nave] -> [Nave]

--1. Naves débiles: Son aquellas naves que tienen menos de 200 de escudo.

naveDebil :: Estrategia
naveDebil unaNave = escudos unaNave < 200
realizarElAtaque estrategia atacante  = map (combate atacante) . filter estrategia 
--2. Naves con cierta peligrosidad: Son aquellas naves que tienen un ataque mayor a un valor dado. 
--   Por ejemplo, en alguna misión se podría utilizar una estrategia de peligrosidad mayor a 300, y en otra una estrategia de peligrosidad mayor a 100.

navePeligrosa :: Int -> Estrategia
navePeligrosa peligrosidad unaNave = ataque unaNave > peligrosidad

--3. Naves que quedarían fuera de combate: Son aquellas naves de la flota que luego del ataque de la nave atacante quedan fuera de combate.

naveDesarmada :: Nave -> Estrategia
naveDesarmada atacante = fueraDeCombate . combate atacante 

-- 6. Considerando una nave y una flota enemiga en particular, dadas dos estrategias, 
-- determinar cuál de ellas es la que minimiza la durabilidad total de la flota atacada y llevar adelante una misión con ella.

mejorEstrategia :: Estrategia -> Estrategia -> Nave -> [Nave] -> [Nave]
mejorEstrategia estrategia1 estrategia2 atacante flota
  | esAMejoreQueB estrategia1 estrategia2 atacante flota = ataqueAFlota estrategia1 atacante flota
  | otherwise = ataqueAFlota estrategia2 atacante flota


esAMejoreQueB :: Estrategia -> Estrategia -> Nave -> [Nave] -> Bool
esAMejoreQueB estrategia1 estrategia2 atacante flota = durabilidadDeUnaEstrategia estrategia1 atacante flota < durabilidadDeUnaEstrategia estrategia2 atacante flota

durabilidadDeUnaEstrategia :: Estrategia -> Nave -> [Nave] -> Int
durabilidadDeUnaEstrategia estrategia atacante flota = durabilidadTotal (ataqueAFlota estrategia atacante flota)

-- 7. Construir una flota infinita de naves. ¿Es posible determinar su durabilidad total? 
-- ¿Qué se obtiene como respuesta cuando se lleva adelante una misión sobre ella? Justificar conceptualmente.

flotaInfinita :: Nave -> [Nave]
flotaInfinita  = repeat
 
-- no es posible calcular la durabilidad de una cantidad infinitas de naves, ya que sea un calculo infinito y por el mismo motivo no es posible realizar un ataqueAFlota



