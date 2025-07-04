module Solucion where
import Text.Show.Functions()

type Derrota = (String,Int)
type Objeto = Personaje -> Personaje

data Personaje = UnPersonaje {
    nombre :: String,
    cantidadDePoder :: Int,
    derrotas :: [Derrota],
    equipamiento :: [Objeto]
}

mapCantidadDePoder :: (Int -> Int) -> Personaje -> Personaje
mapCantidadDePoder funcion unPersonaje = unPersonaje {cantidadDePoder = max 0 . funcion . cantidadDePoder $ unPersonaje}

mapDerrotas :: ([Derrota] -> [Derrota]) -> Personaje -> Personaje
mapDerrotas funcion unPersonaje = unPersonaje {derrotas = funcion . derrotas $ unPersonaje}

entrenamientoIndivudual :: Int -> Personaje -> Personaje
entrenamientoIndivudual cantidadDeEntreno unPersonaje = mapCantidadDePoder (* cantidadDeEntreno) unPersonaje

entrenamiento :: [Personaje] -> [Personaje]
entrenamiento personajes = map (entrenamientoIndivudual . length $ personajes)  personajes

tieneSuficientePoder :: Personaje -> Bool
tieneSuficientePoder unPersonaje = (>= 500).cantidadDePoder $ unPersonaje 

obtenerDerrotas :: Personaje -> [String]
obtenerDerrotas unPersonaje = map fst.derrotas $ unPersonaje

vencioA ::  String -> Personaje -> Bool
vencioA rival unPersonaje = elem rival (obtenerDerrotas unPersonaje)

esDigno :: Personaje -> Bool
esDigno unPersonaje = tieneSuficientePoder unPersonaje && vencioA "HijoDeThanos" unPersonaje

rivalesDignos :: [Personaje] -> [Personaje]
rivalesDignos = filter esDigno . entrenamiento

{- zipwith sirve para aplicar una funcion entre 2 listas y recibe una sola con los cambios aplicados
   zip recibe dos lista y crea una lista con tupla de los elementos de ambas listas-}

agregarDerrota :: Derrota -> Personaje -> Personaje
agregarDerrota laDerrota unPersonaje = mapDerrotas ((:)laDerrota) unPersonaje

ganaA :: Int -> Personaje -> Personaje -> Personaje
ganaA anio unPersonaje rival
  | cantidadDePoder unPersonaje > cantidadDePoder rival = agregarDerrota (nombre rival,anio) unPersonaje
  | otherwise = agregarDerrota (nombre unPersonaje,anio) rival

guerraCivil :: Int -> [Personaje] -> [Personaje] -> [Personaje]
guerraCivil anio unosPersonajes otrosPersonajes = zipWith (ganaA anio) unosPersonajes otrosPersonajes

-- Parte B
-- &-----------------------------------------------------------------

escudo :: Objeto
escudo unPersonaje 
  | (length.obtenerDerrotas $ unPersonaje) < 5 = mapCantidadDePoder (+50) unPersonaje
  | otherwise = mapCantidadDePoder (subtract 100) unPersonaje