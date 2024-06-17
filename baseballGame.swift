//
//  baseballGame.swift
//  baseballGame
//
//  Created by 단예진 on 6/17/24.
//

// readLine() 함수를 이용하여 유저의 입력값 처리하기
// readLine() 함수에 대해 학습해보고 활용하기
// 요구사항별로 상세 기능을 생각해요 / 사용하면서 발생할 수 있는 예외사항들을 고려해봅니다.

/* Lv.1
 1에서 9까지의 서로 다른 임의의 수 3개를 정하고 맞추는 게임입니다
 정답은 랜덤으로 만듭니다.(1에서 9까지의 서로 다른 임의의 수 3자리)*/

/* Lv.2
 정답을 맞추기 위해 3자리수를 입력하고 힌트를 받습니다
 힌트는 야구용어인 **볼**과 **스트라이크**입니다.
 같은 자리에 같은 숫자가 있는 경우 **스트라이크**, 다른 자리에 숫자가 있는 경우 **볼**입니다
 정답 : 456 인 경우
 - 435를 입력한 경우 → 1스트라이크 1볼
 - 357를 입력한 경우 → 1스트라이크
 - 678를 입력한 경우 → 1볼
 - 123를 입력한 경우 → Nothing
 - 만약 올바르지 않은 입력값에 대해서는 오류 문구를 보여주세요
 - 3자리 숫자가 정답과 같은 경우 게임이 종료됩니다*/

// 제한사항 : 0 입력 불가, string 입력 불가, 같은 숫자 출력 불가





// 질문 게임로직을 짤 때 이렇게 해도 되는지 문제를 잘 이해했는지
/* 게임 로직
 1. Baseballgame class 생성 : 게임 프로퍼티 및 메서드 생성(입력 안내, 랜덤 숫자 출력, 정답 확인, 게임 종료)
 2. 게임 기능
 2-1. 사용자가 임의의 숫자 세개를 입력
 2-2. 사용자가 입력한 수가 오류를 유발하는지 검사한다.(0인지, string값인지, 임의의 수가 서로 중복되는지)
 2-3. 함수 내부 구현 : 랜덤 숫자 세개를 출력할 수 있는 함수 선언
 2-4. 사용자가 선택한 임의의 수 3개와 출력된 랜덤 숫자를 확인한다.
 - Strike 출력 : 랜덤 숫자가 사용자의 임의의 수와 동일한 숫자가 동일한 위치일 때
 - Ball 출력 : 랜덤 숫자가 사용자의 임의의 세개 중 하나와 일치할 때
 - Strike and Ball : 두 조건을 모두 만족시킬 때
 - Nothing 출력 : 사용자의 임의의 수가 그 어떤 조건도 만족시키지 못할 때
 - Correct 출력 : 3자리 숫자가 정확히 일치할 때 -> 나중에 Correct일 때 게임 종료 해보고 싶음
 3. 게임 구현 : BaseballGame 인스턴스 생성 및 start 함수 호출
 3-1. 사용자 숫자 입력 :*/



class BaseballGame {
    private static var answer: [Int] = []
    private var attempts: Int = 0
    private let maxAttempts = 3
    
    
    // 게임 시작
    func start() {
        if BaseballGame.answer.isEmpty {
            BaseballGame.answer = makeAnswer()
        }
        
        print("Let the game begins!")
//        print("The answer is \(BaseballGame.answer)") // 게임 테스트용
        play()
    }
    
    // 랜덤 숫자 생성
    private func makeAnswer() -> [Int] {
        let numbers = Array(1...9).shuffled()
        return Array(numbers.prefix(3))
    }
    
    // 사용자 입력 유효성 검사
    private func isValidInput(_ input: [Int]) -> Bool {
        return input.count == 3 && Set(input).count == 3 && input.allSatisfy { $0 > 0 && $0 < 10 }
    }
    
    // 게임 플레이
    private func play() {
        while attempts < maxAttempts {
            print("Please enter 3 numbers between 1 and 9.", terminator: " ")
            if let userInput = readLine() {
                let userNumbers = userInput.compactMap { Int(String($0)) }
                if isValidInput(userNumbers) {
                    let (strike, ball) = checkGuess(userNumbers)
                    attempts += 1
                    if strike == 3 {
                        print("Correct! Game ended.")
                        return
                    } else {
                        print("\(strike) strike, \(ball) ball")
                    }
                } else {
                    print("Invalid input. Please enter 3 numbers between 1 and 9 without duplicates.")
                }
            }
        }
        
        print("Game over! The answer was \(BaseballGame.answer).")
    }
    
    // 사용자 입력과 정답 비교
    private func checkGuess(_ userNumbers: [Int]) -> (strike: Int, ball: Int) {
        var strikeCount = 0
        var ballCount = 0
        
        for i in 0..<userNumbers.count {
            if userNumbers[i] == BaseballGame.answer[i] {
                strikeCount += 1
            } else if userNumbers.contains(BaseballGame.answer[i]) {
                ballCount += 1
            }
        }
        
        return (strikeCount, ballCount)
    }
}

