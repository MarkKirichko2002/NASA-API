//
//  NASATabBarController.swift
//  NASA API
//
//  Created by Марк Киричко on 17.01.2023.
//

import UIKit
import SDWebImage

final class NASATabBarController: UITabBarController, Coordinating {
    
    // MARK: - сервисы
    private let nasaService: NASAServiceProtocol?
    private let animation: AnimationClassProtocol?
    private let speechRecognition: SpeechRecognitionProtocol?
    private let factory: NASAScreenFactoryProtocol?
    
    var coordinator: Coordinator?
    
    private let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = button.frame.width / 2
        button.clipsToBounds = true
        return button
    }()
    private var isStart: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        UITabBar.appearance().tintColor = UIColor.black
        view.backgroundColor = .systemBackground
        SetUpTabs()
        createMiddleButton()
    }
    
    // MARK: - Init
    init(nasaService: NASAServiceProtocol?, animation: AnimationClassProtocol?, speechRecognition: SpeechRecognitionProtocol?, factory: NASAScreenFactoryProtocol?) {
        self.nasaService = nasaService
        self.animation = animation
        self.speechRecognition = speechRecognition
        self.factory = factory
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
    
    private func SetUpTabs() {
        
        guard let imageCategoriesVC = factory?.createNASAScreens(screen: .imagecategories) else {return}
        guard let asteroidsVC = factory?.createNASAScreens(screen: .asteroids) else {return}
        guard let mediaLibrary = factory?.createNASAScreens(screen: .videolibrary) else {return}
        let middleButton = UIViewController()
        guard let marsWeatherVC = factory?.createNASAScreens(screen: .marsweather) else {return}
    
        setViewControllers([imageCategoriesVC,asteroidsVC,middleButton,mediaLibrary,marsWeatherVC], animated: true)
    }
    
    private func createMiddleButton() {
        button.setImage(UIImage(named: "NASA"), for: .normal)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 32
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        // Устанавливаем положение кнопки по середине TabBar
        button.center = CGPoint(x: tabBar.frame.width / 2, y: tabBar.frame.height / 2 - 10)
        // Назначаем действие для кнопки
        button.addTarget(self, action: #selector(VoiceCommands), for: .touchUpInside)
        // Добавляем кнопку на TabBar
        tabBar.addSubview(button)
    }
    
    @objc private func VoiceCommands(_ sender: UIButton) {
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
        
        // MARK: - VC
        guard let apodVC = factory?.createImageCategoriesScreens(screen: .apod) else {return}
        guard let marsPhotosVC = factory?.createImageCategoriesScreens(screen: .marsphotos) else {return}
        guard let epicVC = factory?.createImageCategoriesScreens(screen: .epic) else {return}
        guard let nasaImagesVC = factory?.createImageCategoriesScreens(screen: .nasaimages) else {return}
        
        switch text {
            
        case _ where text.lowercased().contains("фото дня"):
            
            nasaService?.execute(type: Apod.self, response: .apod) { result in
                switch result {
                case .success(let data):
                    self.button.sd_setImage(with: URL(string: data.hdurl ?? ""), for: .normal)
                    self.animation?.SpringAnimation(view: self.button)
                case .failure:
                    self.button.setImage(UIImage(named: "error"), for: .normal)
                    self.animation?.SpringAnimation(view: self.button)
                }
            }
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.present(apodVC, animated: true)
            }
            
        case _ where text.lowercased().contains("марс"):
            
            self.button.setImage(UIImage(named: "rover"), for: .normal)
            self.animation?.SpringAnimation(view: self.button)
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.present(marsPhotosVC, animated: true)
            }
            
        case _ where text.lowercased().contains("земл"):
            
            self.button.setImage(UIImage(named: "EPIC"), for: .normal)
            self.animation?.SpringAnimation(view: self.button)
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.present(epicVC, animated: true)
            }
            
        case _ where text.lowercased().contains("изображ"):
            
            self.button.setImage(UIImage(named: "camera"), for: .normal)
            self.animation?.SpringAnimation(view: self.button)
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.present(nasaImagesVC, animated: true)
            }
            
        case _ where text.lowercased().contains("муз"):
            
            button.setImage(UIImage(named: "EPIC"), for: .normal)
            
            AudioPlayer.shared.PlaySound(resource: "space music.mp3")
            
            animation?.StartRotateImage(image: self.button.imageView!)
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
        case _ where text.lowercased().contains("выкл"):
            
            button.setImage(UIImage(systemName: "mic.fill"), for: .normal)
            
            AudioPlayer.shared.StopSound(resource: "space music.mp3")
            
            animation?.StopRotateImage(image: self.button.imageView!)
            
            speechRecognition?.cancelSpeechRecognization()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.speechRecognition?.startSpeechRecognition()
            }
            
        case _ where text.lowercased().contains("стоп"):
            
            AudioPlayer.shared.StopSound(resource: "space music.mp3")
            
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
