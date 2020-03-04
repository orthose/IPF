(* Code fonctionnel imitant du code objet *)

(* Déclaration des types basiques *)
type species = Chien | Chat
type point = {x : int; y : int}

(* Déclaration des attributs publics *)
type public_animal = {
    weight : int;
    position : point
}

(* Déclaration des attributs privés *)
type private_animal = {
    speed : float;
    kind : species
}

(* Concaténation des attributs publics et privés *)
type animal = {
    public_attributes : public_animal;
    private_attributes : private_animal
}

(* Constructeur de classe *)
let animal kind =
    {
        public_attributes =
            { weight = 
                (match kind with
                | Chien -> 10
                | Chat -> 5
                );
              position = {x=0;y=0}
            };
            
        private_attributes =
            { speed = 0.;
              kind = kind
            }
    }
    
(* Getters *)
let getWeight animal = animal.public_attributes.weight

let getPosition animal = animal.public_attributes.position

let getSpeed animal = animal.private_attributes.speed

let getKind animal = animal.private_attributes.kind

(* Setters *)
let setWeight animal weight = {animal with public_attributes = {animal.public_attributes with weight = weight}}

let setPosition animal position = {animal with public_attributes = {animal.public_attributes with position = position}}

let setSpeed animal speed = {animal with private_attributes = {animal.private_attributes with speed = speed}}

let setKind animal kind = {animal with private_attributes = {animal.private_attributes with kind = kind}}

(* Méthodes *)
let print animal =
    let { public_attributes = {weight = w; position = {x=x;y=y}}; 
          private_attributes = {speed = s; kind = k}
        } = animal 
    in
    let k =
        match k with
        | Chien -> "Chien"
        | Chat -> "Chat"
    in
    Printf.printf "{weight=%d;position=(%d,%d);speed=%f;kind=%s}\n" w x y s k

(* Tests *)
let mon_chat = animal Chat

let () = print mon_chat

let mon_chat = setWeight mon_chat 6

let () = print mon_chat










                
