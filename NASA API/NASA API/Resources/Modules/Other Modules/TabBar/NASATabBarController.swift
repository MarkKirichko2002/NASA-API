//
//  NASATabBarController.swift
//  NASA API
//
//  Created by Марк Киричко on 17.01.2023.
//

import UIKit
import SDWebImage
import Swinject

class NASATabBarController: UITabBarController {
    
    private let animation: AnimationClassProtocol?
    private let player: SoundClassProtocol?
    private let speechRecognition: SpeechRecognitionProtocol?
    
    private let container: Container = {
        let container = Container()
        // Mars Weather Presenter
        container.register(MarsWeatherPresenter.self) { resolver in
            let presenter = MarsWeatherPresenter(nasaService: resolver.resolve(NASAServiceProtocol.self))
            return presenter
        }
        return container
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = button.frame.width / 2
        button.clipsToBounds = true
        return button
    }()
    private var isStart: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = UIColor.black
        view.backgroundColor = .systemBackground
        SetUpTabs()
        createMiddleButton()
    }
    
    init(animation: AnimationClassProtocol?, player: SoundClassProtocol?, speechRecognition: SpeechRecognitionProtocol?) {
        self.animation = animation
        self.player = player
        self.speechRecognition = speechRecognition
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Override selectedViewController for User initiated changes
    override var selectedViewController: UIViewController? {
        didSet {
            tabChangedTo(selectedIndex: selectedIndex)
        }
    }
    // Override selectedIndex for Programmatic changes
    override var selectedIndex: Int {
        didSet {
            tabChangedTo(selectedIndex: selectedIndex)
        }
    }
    
    func tabChangedTo(selectedIndex: Int) {
        UserDefaults.standard.set(selectedIndex, forKey: "index")
        switch selectedIndex {
            
        case 0:
            break
        case 1:
            break
        case 3:
            break
        case 4:
            break
        default:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        button.frame = CGRect.init(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 100, width: 64, height: 64)
        button.layer.cornerRadius = 32
    }
    
    private func SetUpTabs() {
        
        let imageCategoriesVC = NASAImageCategoriesListViewController()
        let asteroidsVC = AsteroidsViewController()
        let mediaLibrary = NASAVideosTableViewController()
        let middleButton = UIViewController()
        let marsWeatherVC = MarsWeatherViewController(presenter: container.resolve(MarsWeatherPresenter.self))
        let settingsVC = NASASettingsViewController()
        
        imageCategoriesVC.navigationItem.largeTitleDisplayMode = .automatic
        asteroidsVC.navigationItem.largeTitleDisplayMode = .automatic
        mediaLibrary.navigationItem.largeTitleDisplayMode = .automatic
        marsWeatherVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = UINavigationController(rootViewController: imageCategoriesVC)
        let nav2 = UINavigationController(rootViewController: asteroidsVC)
        let nav3 = UINavigationController(rootViewController: mediaLibrary)
        let nav4 = UINavigationController(rootViewController: marsWeatherVC)
        let nav5 = UINavigationController(rootViewController: settingsVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Изображения", image: UIImage(named: "images"), selectedImage: UIImage(named: "images selected"))
        nav2.tabBarItem = UITabBarItem(title: "Астероиды", image: UIImage(named: "asteroids"), selectedImage: UIImage(named: "asteroids selected"))
        nav3.tabBarItem = UITabBarItem(title: "NASA Видеотека", image: UIImage(named: "video player"), selectedImage: UIImage(named: "video player selected"))
        nav4.tabBarItem = UITabBarItem(title: "Марс Погода", image: UIImage(systemName: "cloud"), selectedImage: UIImage(systemName: "cloud.fill"))
        nav5.tabBarItem = UITabBarItem(title: "Настройки", image: UIImage(systemName: "gear"),
                                       selectedImage: UIImage(systemName: "gear.fill"))
        
        for nav in [nav1,nav2,nav3,nav4] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([nav1,nav2,middleButton,nav3,nav4], animated: true)
    }
    
    private func createMiddleButton() {
        button.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        button.layer.borderWidth = 2
        button.setImage(UIImage(named: "NASA"), for: .normal)
        self.view.insertSubview(button, aboveSubview: self.tabBar)
        button.addTarget(self, action:  #selector(NASATabBarController.VoiceCommands(_:)), for: .touchUpInside)
    }
    
    @objc func VoiceCommands(_ sender: UIButton) {
        isStart = !isStart
        if isStart {
            button.setImage(UIImage(systemName: "mic.fill"), for: .normal)
            button.imageView?.tintColor = .black
            animation?.SpringAnimation(view: button)
            speechRecognition?.startSpeechRecognition()
            speechRecognition?.registerSpeechRecognitionHandler { text in
                self.CheckVoiceCommands(text: text)
            }
        } else {
            button.setImage(UIImage(named: "NASA"), for: .normal)
            animation?.SpringAnimation(view: button)
            speechRecognition?.cancelSpeechRecognization()
        }
    }
    
    private func CheckVoiceCommands(text: String) {
        switch text {
            
        case _ where text.lowercased().contains("фото дня"):
            
            NASAService.shared.execute(type: Apod.self, response: .apod) { result in
                switch result {
                case .success(let data):
                    self.button.sd_setImage(with: URL(string: data.hdurl ?? ""), for: .normal)
                    self.animation?.SpringAnimation(view: self.button)
                case .failure:
                    self.button.setImage(UIImage(named: "error"), for: .normal)
                    self.animation?.SpringAnimation(view: self.button)
                }
            }
            
            let vc = APODViewController(presenter: container.resolve(APODPresenter.self))
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.present(vc, animated: true)
            }
            
        case _ where text.lowercased().contains("марс"):
            
            self.button.setImage(UIImage(named: "rover"), for: .normal)
            self.animation?.SpringAnimation(view: self.button)
            
            let vc = MarsPhotosViewController()
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.present(vc, animated: true)
            }
            
        case _ where text.lowercased().contains("земл"):
            
            self.button.setImage(UIImage(named: "EPIC"), for: .normal)
            self.animation?.SpringAnimation(view: self.button)
            
            let vc = EPICNASAImagesViewController()
             
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.present(vc, animated: true)
            }
            
        case _ where text.lowercased().contains("изображ"):
            
            self.button.setImage(UIImage(named: "camera"), for: .normal)
            self.animation?.SpringAnimation(view: self.button)
            
            let vc = NASAImageLibraryViewController()
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.present(vc, animated: true)
            }
            
        case _ where text.lowercased().contains("муз"):
            
            button.setImage(UIImage(named: "EPIC"), for: .normal)
            
            player?.PlaySound(resource: "space music.mp3")
            
            animation?.StartRotateImage(image: self.button.imageView!)
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
        case _ where text.lowercased().contains("выкл"):
            
            button.setImage(UIImage(systemName: "mic.fill"), for: .normal)
            
            player?.StopSound(resource: "space music.mp3")
            
            animation?.StopRotateImage(image: self.button.imageView!)
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
        case _ where text.lowercased().contains("стоп"):
            
            player?.StopSound(resource: "space music.mp3")
            
            animation?.StopRotateImage(image: self.button.imageView!)
            
            button.sendActions(for: .touchUpInside)
            
        case _ where text.lowercased().contains("закр"):
            self.dismiss(animated: true)
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
        default:
            break
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        animation?.TabBarItemAnimation(item: item)
    }
}
