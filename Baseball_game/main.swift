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
//  아웃: 세 숫자 중 맞는 숫자가 전혀 없는 경우.
// 게임 종료 조건:
//  사용자가 컴퓨터가 임의로 설정한 숫자 3개를 모두 맞추면 종료

// Lv 1 : 1~9까지의 서로 다른 임의의 수 3가지 입력, 정답은 랜덤으로 설정
// Lv 2 : 숫자를 입력하면 스트라이크와 볼로 힌트를 받는다
// Lv 3 : 숫자 범위를 0~9로 변경하지만 첫째 자리는 0이 올 수 없다.

// 1~9의 서로 다른 임의의 수 3개 생성
func threeNumber() -> [Int] {
    var numbers: [Int] = []
    
    while numbers.count < 1{
        let randomNumber = Int.random(in: 1...9)
        if !numbers.contains(randomNumber) {
            numbers.append(randomNumber)
        }
    }
    
    while numbers.count < 3 {
        let randomNumber = Int.random(in: 0...9)
        if !numbers.contains(randomNumber) {
            numbers.append(randomNumber)
        }
    }
    
    return numbers
}

// 스트라이크, 볼, 아웃 판정 함수
func check(computer: [Int], user: [Int]) -> (strikes: Int, balls: Int) {
    var strikes = 0
    var balls = 0
    
    for i in 0..<3 {
        if computer[i] == user[i] {
            strikes += 1 // 위치와 숫자 모두 맞으면 스트라이크
        } else if computer.contains(user[i]) {
            balls += 1 // 위치는 다르지만 숫자가 맞으면 볼
        }
    }
    
    return (strikes, balls)
}

let secretNumbers = threeNumber()
print("서로 다른 임의의 수 0~9 3개를 입력하세요 (예: 1 2 3)")
var count = 0

while true {
    if let input = readLine() {
        let userInput = input.split(separator: " ").compactMap { Int($0) }
        
        // 입력된 숫자가 3개이고 서로 다른 숫자인지 확인
        if userInput.count == 3 && Set(userInput).count == 3 {
            
            if userInput[0] == 0{
                print("첫번째 수는 0이 될 수 없습니다!!")
                continue
            }
            
            count += 1
            let result = check(computer: secretNumbers, user: userInput)
            
            if result.strikes == 3 {
                print("\(count)번만에 정답입니다! 게임 종료!")
                break
            } else {
                print("사용자의 입력 : \(userInput[0])")
                print(secretNumbers)
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
