//
//  GameScene.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//
import SpriteKit

class GameScene: SKScene {
    private var currentPokemonNode: SKSpriteNode?

    override func didMove(to view: SKView) {
        backgroundColor = .white
    }

    func fetchRandomPokemon() {
        let randomId = Int.random(in: 1...151)
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(randomId)")!

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let sprites = json["sprites"] as? [String: Any],
                  let imageUrlStr = sprites["front_default"] as? String,
                  let imageUrl = URL(string: imageUrlStr),
                  let imageData = try? Data(contentsOf: imageUrl),
                  let uiImage = UIImage(data: imageData) else {
                print("Ошибка загрузки покемона")
                return
            }

            DispatchQueue.main.async {
                self.showPokemon(image: uiImage)
            }
        }.resume()
    }

    func showPokemon(image: UIImage) {
        currentPokemonNode?.removeFromParent()

        let texture = SKTexture(image: image)
        let sprite = SKSpriteNode(texture: texture)
        sprite.position = CGPoint(x: size.width / 2, y: size.height / 2)
        sprite.setScale(2.5)

        addChild(sprite)
        currentPokemonNode = sprite
    }
}
