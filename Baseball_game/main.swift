//
//  main.swift
//  Baseball_game
//
//  Created by 김석준 on 11/4/24.
//

//야구 스트라이크 볼 게임은 컴퓨터가 생성한 세 자리의 서로 다른 숫자와, 플레이어가 입력한 세 자리의 서로 다른 숫자를 비교해 결과를 알려주는 숫자 맞추기 게임입니다.

//게임 규칙
//목표: 플레이어는 컴퓨터가 생각한 숫자를 맞춰야 합니다.
//숫자 구성: 컴퓨터는 1부터 9까지의 숫자 중 서로 다른 3개의 숫자를 무작위로 선택해 비밀 숫자를 만듭니다.
//플레이어 입력: 플레이어는 컴퓨터의 비밀 숫자를 추측하며 세 자리의 숫자를 입력합니다.
//결과 판정:
//  스트라이크: 플레이어가 입력한 숫자와 위치가 모두 맞는 경우.
//  볼: 플레이어가 입력한 숫자는 맞지만 위치가 다른 경우.
//  아웃: 세 숫자 중 맞는 숫자가 전혀 없는 경우.
//게임 종료 조건:
//  사용자가 컴퓨터가 임의로 설정한 숫자 3개를 모두 맞추면 종료

//Lv 1
// 1~9 임의의 수 3개를 입력하고 맞추기 정답은 랜덤으로 설정

// 1~9의 서로 다른 임의의 수 3개 생성
func threeNumber() -> [Int] {
    var numbers: [Int] = []
    
    while numbers.count < 3 {
        let randomNumber = Int.random(in: 1...9)
        
        if !numbers.contains(randomNumber) {
            numbers.append(randomNumber)
        }
    }
    
    return numbers
}

print("서로 다른 임의의 수 3개를 입력하세요 (예: 1 2 3)")

if let input = readLine() {
    let userNumber = input.split(separator: " ").compactMap { Int($0) }
    
    // 입력된 숫자가 3개이고 서로 다른 숫자인지 확인
    if userNumber.count == 3 && Set(userNumber).count == 3 {
        let randomNumber = threeNumber()
        print("랜덤 숫자 3개: \(randomNumber)")
    } else {
        print("잘못된 입력입니다. 서로 다른 3개의 숫자를 입력하세요.")
    }
} else {
    print("입력이 없습니다.")
}
