//
//  ViewController.swift
//  fightcamp-onsite
//
//  Created by Landon Rohatensky on 2023-04-14.
//

import UIKit
import Combine

class ViewController: UIViewController {
    private let viewModel = ViewModel()
    
    private let stackView = UIStackView()
    let textView = WorkoutCard()
    private var cancellables: Set<AnyCancellable> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            do {
                let workouts = try await viewModel.loadWorkouts()
                _ = try await viewModel.loadNextPage()
            } catch {
                print(error)
            }
        }
        view.backgroundColor = .brandGray0
        view.addSubview(stackView)
        stackView.pinToSafeArea(superView: view)
        stackView.alignment = .top
        stackView.addArrangedSubview(textView)
//        Task {
//            do {
//                _ = await viewModel.loadTrainers()
//            } catch {
//                print(error)
//            }
//        }
        // Do any additional setup after loading the view.
        
        viewModel.items
            .receive(on: RunLoop.main)
            .sink { completion in
            switch completion {
            case .finished:
                print("complete")
            case .failure(let error):
                print(error)
            }
        } receiveValue: { [weak textView] workouts in
            if let workout = workouts.first {
                textView?.configure(workout: workout)
            }
        }.store(in: &cancellables)

    }


}

