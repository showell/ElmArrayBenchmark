module Main exposing (main, suite)

import Array exposing (Array)
import Benchmark exposing (..)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import Random


main : BenchmarkProgram
main =
    program suite


normalize lst =
    lst
        |> List.indexedMap Tuple.pair
        |> List.sortBy Tuple.second
        |> List.map Tuple.first
        |> List.indexedMap Tuple.pair
        |> List.sortBy Tuple.second
        |> List.map Tuple.first


normalize2 lst =
    let
        zeroes : Array Int
        zeroes =
            Array.repeat (List.length lst) 0

        update : ( Int, ( Int, a ) ) -> Array Int -> Array Int
        update tup arr =
            let
                ( idx1, ( idx2, _ ) ) =
                    tup
            in
            Array.set idx2 idx1 arr
    in
    lst
        |> List.indexedMap Tuple.pair
        |> List.sortBy Tuple.second
        |> List.indexedMap Tuple.pair
        |> List.foldl update zeroes
        |> Array.toList


suite : Benchmark
suite =
    let
        seed =
            Random.initialSeed 42

        lst =
            Random.list 500 (Random.float 0 1)
                |> (\x -> Random.step x seed)
                |> Tuple.first

        _ =
            Debug.log "equal?" ( List.length lst, normalize lst == normalize2 lst )
    in
    describe "normalize"
        [ benchmark "with two sorts" <|
            \_ -> normalize lst
        , benchmark "with array" <|
            \_ -> normalize2 lst
        ]
