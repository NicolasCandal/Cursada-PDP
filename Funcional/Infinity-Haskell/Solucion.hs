module Solucion where
import Text.Show.Functions()

type Derrota = (Nombre,AnioDeDerrota)
type AnioDeDerrota = Int
type Nombre = String

data Personaje = UnPersonaje {
    nombre :: String,
    cantidadDePoder :: Int,
    derrotas :: [Derrota]
} deriving Show

ironMan :: Personaje
ironMan = UnPersonaje "Iron Man" 500 [("Thanos",2019),("CAP",2007)]

panteraNegra :: Personaje
panteraNegra = UnPersonaje "Pantera Negras" 420 [("Ant Man",2007)]

spiderMan :: Personaje
spiderMan = UnPersonaje "Spider Man" 625 [("CAP",2007),("Duende Verde",2005),("Rhino",2006)]

trioLoco :: [Personaje]
trioLoco = [ironMan,panteraNegra,spiderMan]

mapCantidadDePoder :: (Int -> Int) -> Personaje -> Personaje
mapCantidadDePoder funcion unPersonaje = unPersonaje {cantidadDePoder = max 0 . funcion . cantidadDePoder $ unPersonaje}

mapDerrotas :: ([Derrota] -> [Derrota]) -> Personaje -> Personaje
mapDerrotas funcion unPersonaje = unPersonaje {derrotas = funcion . derrotas $ unPersonaje}


-- &----------------------------------------------------------------------------------------------------------------
-- Punto 1: Modelar entrenamiento

cantidadDePersonajes :: [Personaje] -> Int
cantidadDePersonajes unosPersonajes = length unosPersonajes

entranarUnPersonaje :: Int -> Personaje -> Personaje
entranarUnPersonaje multiplicador unPersonaje = mapCantidadDePoder (* multiplicador) unPersonaje

entrenamiento :: [Personaje] -> [Personaje]
entrenamiento personajes = map (entranarUnPersonaje.cantidadDePersonajes $ personajes) personajes