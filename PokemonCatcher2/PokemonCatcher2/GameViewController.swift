//
//  GameViewController.swift
//  PokemonCatcher2
//
//  Created by Ерасыл on 19.05.2025.
//
import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.view as! SKView? {
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .resizeFill
            view.presentScene(scene)
        }

        setupFindButton()
    }

    func setupFindButton() {
        let button = UIButton(type: .system)
        button.setTitle("Найти Покемона", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false

        button.addTarget(self, action: #selector(findPokemonTapped), for: .touchUpInside)

        view.addSubview(button)

        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func findPokemonTapped() {
        if let skView = self.view as? SKView,
           let gameScene = skView.scene as? GameScene {
            gameScene.fetchRandomPokemon()
        }
    }
}
