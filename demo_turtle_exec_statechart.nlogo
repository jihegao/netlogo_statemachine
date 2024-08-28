;
;
__includes [ ]

extensions [ table profiler ]

turtles-own [
  current_state
]



globals [
  states
  state_functions
]


to setup
  clear-all
  reset-ticks
  set-default-shape turtles "bug"
  ;; randomly distribute wood chips
  ask patches [
    if random 100 < density
      [ set pcolor yellow ]
  ]

  set state_functions table:make
  set states table:get (table:from-json-file "statechart.json") "states"
  foreach states [
    s ->

    ifelse (table:has-key? s "trigger_func")
    [
      let trigger_func table:get s "trigger_func"
      table:put s "trigger_func" trigger_func
    ]
    [
      let trigger table:get s "trigger"
      table:put s "trigger" trigger
    ]
    let name table:get s "state_name"
    let trigger table:get s "trigger"
    let next_state table:get s "next_state"
    let function gen-func name trigger next_state "action"
    table:put state_functions name function
  ]

  create-turtles number [ __init__  ]
end


to __init__
  set color blue
  set size 2
  update-current-state "search-for-chip"
  move-to one-of patches with [pcolor = black]
end



to go
  ask turtles [
    execute-state
  ]
  tick
end

to wiggle  ;; turtle procedure
  lt random 50
  rt random 50
end


to search-for-chip   ;; turtle procedure
  wiggle fd 1
end

to-report has-free-chip-here?
  report pcolor = yellow and not any? other turtles-here
end

to pick-up-chip     ;; "picks up chip" by turning orange
  set pcolor black
  set color orange
end

to find-new-pile  ;;  look for yellow patches
  wiggle fd 1
end

to find-place-to-put-down-chip  ;; finds empty spot
  wiggle fd 1
end

to-report is-empty-here?
  report pcolor = black and not any? other turtles-here
end

to put-down-chip  ;;   drops chip
  set pcolor yellow
  set color white
end

to get-away  ;;   get out of yellow pile
  wiggle fd 1
end



; ===================
;    STATE MACHINE
; ===================


; turtle reporter
to-report get_state_function [state_name]
  ;report first filter [s -> table:get s "state_name" = state_name] states
  report table:get state_functions state_name
end


to update-current-state [state_name]
;  let next_state (get_state state_name)
;  let trigger table:get next_state "trigger"
;  let next_state_name table:get next_state "next_state"
;  set current_state gen-func state_name trigger next_state_name
  set current_state get_state_function state_name
  if show-logs? [
    set label state_name_of current_state
    show (word "enter state: " label ) ]
end


to-report gen-func [ state_name action triggers next_state_name ]
  report (runresult
    (word
    "[ key -> "
    "  (ifelse-value "
    "  ( key = \"trigger\" ) [ " triggers " ]"
    "  ( key = \"next_state\") [\"" next_state_name "\" ]"
    "  ( key = \"state_name\") [\"" state_name "\" ] "
    "  ( key = \"action\") [ " action " ]"
    "  )"
    "]" )
  )
end


to-report demo-func [ state_name action triggers next_state_name ]
  report [ key ->
    (ifelse-value
      (key = "trigger") [ triggers ]
      (key = "next_state") [ next_state_name ]
      (key = "state_name") [ state_name ]
      (key = "action") [ action ]
    )
  ]
end

;;

to execute-state
  ; transfer to new state if any transfer rule is meet
  let fulfilled (runresult current_state "trigger")
  if fulfilled [
    update-current-state (runresult current_state "next_state")
  ]
  run (runresult current_state "action")
end



to-report state_name_of [state]
  report (runresult state "state_name")
end

to-report time-after [interval]
  let it ifelse-value (is-string? interval)[read-from-string interval][interval]
  report [ -> expired-at (ticks + it) ]
end

to-report expired-at [t]
  report ticks >= t
end
@#$#@#$#@
GRAPHICS-WINDOW
150
10
579
440
-1
-1
2.095
1
8
1
1
1
0
1
1
1
-100
100
-100
100
1
1
1
ticks
30.0

BUTTON
10
15
135
48
NIL
setup\n
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
75
145
138
178
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
10
145
73
178
NIL
go
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
10
320
137
353
show-logs?
show-logs?
1
1
-1000

SLIDER
10
75
135
108
number
number
0
500
400.0
1
1
NIL
HORIZONTAL

SLIDER
10
110
135
143
density
density
0
100
20.0
1
1
NIL
HORIZONTAL

MONITOR
615
25
852
70
NIL
count patches with [pcolor = yellow]
17
1
11

@#$#@#$#@
## WHAT IS IT?

An alternative implementation of the official model 'State Machine Example'. Use an external JSON file to define the bugs' statechart, and imported into a turtles-own statechart (a netlogo table or dictionary). 

## HOW IT WORKS

A state machine consists of state names, state behaviors, and transitions between states. We use key "name" to refer state name, key "action" to refer behaviors, and key "transfer_conditions" to refer transition rules.

Actions are strings which are executable by run "run action", 

## THINGS TO TRY



## EXTENDING THE MODEL



## RELATED MODELS
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

carrier4
true
0
Polygon -7500403 false true 75 285 45 90 90 75 90 15 180 15 180 90 225 105 225 270 180 285 75 285
Polygon -13791810 true false 135 135
Polygon -7500403 true true 75 285 180 285 225 270 225 105 180 90 180 15 90 15 90 75 45 90 75 285 180 285

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.4.0
@#$#@#$#@
setup
draw-countries
make-city-turtles
set num-citizens-to-create 5
create-citizens-in-countries
display-population-in-patches
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
1
@#$#@#$#@
