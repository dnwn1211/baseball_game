//  main.swift
//  Baseball_game

// 야구 스트라이크 볼 게임은 컴퓨터가 생성한 세 자리의 서로 다른 숫자와, 플레이어가 입력한 세 자리의 서로 다른 숫자를 비교해 결과를 알려주는 숫자 맞추기 게임입니다.

// 게임 규칙
// 목표: 플레이어는 컴퓨터가 생각한 숫자를 맞춰야 합니다.
// 숫자 구성: 컴퓨터는 1부터 9까지의 숫자 중 서로 다른 3개의 숫자를 무작위로 선택해 비밀 숫자를 만듭니다.
// 플레이어 입력: 플레이어는 컴퓨터의 비밀 숫자를 추측하며 세 자리의 숫자를 입력합니다.
// 결과 판정:
//  스트라이크: 플레이어가 입력한 숫자와 위치가 모두 맞는 경우.
//  볼: 플레이어가 입력한 숫자는 맞지만 위치가 다른 경우.

// 게임 종료 조건:
//  사용자가 컴퓨터가 임의로 설정한 숫자 3개를 모두 맞추면 종료

// Lv 1 : 1~9까지의 서로 다른 임의의 수 3가지 입력, 정답은 랜덤으로 설정
// Lv 2 : 숫자를 입력하면 스트라이크와 볼로 힌트를 받는다
// Lv 3 : 숫자 범위를 0~9로 변경하지만 첫째 자리는 0이 올 수 없다.
// Lv 4 : 프로그램 시작할 때 안내 문구 1. 게임 시작하기, 2. 게임 기록 보기, 3. 종료하기
// Lv 5 : 2. 게임 기록 보기를 입력하면 클리어한 게임의 시도 횟수를 보여줌
// Lv 6 : 3. 종료하기 : 게임이 종료됨

import Foundation

// 1~9의 서로 다른 임의의 수 3개 생성
func random_threeNumber() -> [Int] {
    // 임의로 생성할 숫자 배열
    var numbers: [Int] = []
    
    // 첫 번째 자리 1~9
    let randomNumber = Int.random(in: 1...9)
    numbers.append(randomNumber)
    
    // 두 번째, 세 번쨰 자리 0~9
    while numbers.count < 3 {
        let randomNumber = Int.random(in: 0...9)
        // .contains으로 중복검사
        if !numbers.contains(randomNumber) {
            numbers.append(randomNumber)
        }
    }
    
    return numbers
}

// 스트라이크, 볼 판정 함수
func strike_ball(computer: [Int], user: [Int]) -> (strikes: Int, balls: Int) {
    var strikes = 0
    var balls = 0
    
    for i in 0..<3 {
        // 컴퓨터의 랜덤 숫자와 사용자의 입력 숫자가 같은 위치 같은 숫자라면 strike
        if computer[i] == user[i] {
            strikes += 1
        // 컴퓨터의 랜덤 숫자와 사용자의 입력 숫자가 다른 위치 같은 숫자라면 ball
        } else if computer.contains(user[i]) {
            balls += 1
        }
    }
    
    return (strikes, balls)
}

// 게임 기록 저장 배열
var gameRecords: [Int] = []

// 게임 시작 함수
func startGame() {
    // 랜덤 숫자 생성
    let threeNumber = random_threeNumber()
    // 정답을 맞추기 위해 입력한 횟수
    var count = 0
    
    print("< 게임을 시작합니다 >")
    
    while true {
        // terminator : 줄 바꿈 방지
        print("세 자리의 숫자를 입력하세요 (예: 1 2 3): ", terminator: "")
        
        if let input = readLine() {
            // 숫자를 맞추기 위해 사용자가 입력한 수
            let userInput = input.split(separator: " ").compactMap { Int($0) }
            
            // 입력된 숫자가 3개이고 서로 다른 숫자인지 확인
            if userInput.count == 3 && Set(userInput).count == 3 {
                if userInput[0] == 0 {
                    print("첫 번째 숫자는 0이 될 수 없습니다. 다시 입력하세요.")
                    continue
                }
                
                count += 1
                let result = strike_ball(computer: threeNumber, user: userInput)
                
                if result.strikes == 3 {
                    print("축하합니다!! 정답은 \(userInput). \(count)번 만에 정답입니다! 게임 종료!")
                    gameRecords.append(count)
                    break
                } else {
                    print("\(count) 회차 : \(result.strikes) 스트라이크, \(result.balls) 볼")
                }
            } else {
                print("잘못된 입력입니다. 서로 다른 3개의 숫자를 입력하세요.")
            }
        } else {
            print("입력이 없습니다.")
            break
        }
    }
}

// 게임 기록 보기 함수
func showRecords() {
    if gameRecords.isEmpty {
        print("아직 게임 기록이 없습니다.")
    } else {
        print("게임 기록:")
        for (index, record) in gameRecords.enumerated() {
            print("\(index + 1)회차 : \(record)번 만에 성공")
        }
    }
}

// 게임 시작 안내 함수
func main() {
    while true {
        print("\n환영합니다! 원하시는 번호를 입력해주세요")
        print("1. 게임 시작하기  2. 게임 기록 보기  3. 종료하기")
        
        if let choice = readLine() {
            switch choice {
            // 게임 시작하기
            case "1":
                startGame()
            // 게임 기록 보기
            case "2":
                showRecords()
            // 종료하기
            case "3":
                print("게임을 종료합니다.")
                return
            // 1,2,3 이외의 문자를 입력하면 출력후 안내 문구 다시 출력
            default:
                print("잘못된 입력입니다. 1, 2 또는 3을 입력하세요.")
            }
        } else {
            print("입력이 없습니다.")
        }
    }
}

// 게임 시작 안내 화면
main()
