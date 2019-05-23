//
//  ViewController.swift
//  Lupin3rd
//
//  Created by nh724 on 2018/12/14.
//  Copyright © 2018 西林光. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

	@IBOutlet weak var lbTitle: UILabel!
	
	var ssId01: SystemSoundID = 0
	var ssId02: SystemSoundID = 0
	
	// 処理中フラグ
	var flgPlay = false
	
	// タイトル
	let titles = [
		"ルパンは燃えているか・・・・?!",
		"魔術師と呼ばれた男",
		"さらば愛しき魔女",
		"脱獄のチヤンスは一度",
		"十三代五ヱ門登場",
		"雨の午後はヤバイゼ",
		"狼は狼を呼ぶ",
		"全員集合トランプ作戦",
		"殺し屋はブルースを歌う",
		"ニセ札つくりを狙え!",
		"7番目の橋が落ちるとき",
		"誰が最後に笑ったか",
		"タイムマシンに気をつけろ!",
		"エメラルドの秘密",
		"ルパンを捕まえてヨーロッパへ行こう",
		"宝石横取り作戦",
		"罠にかかったルパン",
		"美人コンテストをマークせよ",
		"どっちが勝つか三代目!",
		"ニセルパンを捕えろ!",
		"ジャジャ馬娘を助けだせ!",
		"先手必勝コンピューター作戦!",
		"黄金の大勝負!"
	]
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		// 初期処理
		initSoundEffect()
	}
	
	// 画面タッチ開始時
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		// 処理中フラグ判定（trueの場合つまり処理が走っている時）
		if flgPlay {
			return
		}
		
		// 処理中フラグON
		flgPlay = true
		
		// 乱数の発生
		let rnd =
			Int(arc4random_uniform(UInt32(titles.count)))
		
		let strTitle = titles[rnd]
//		let strTitle = "あいうえお\nかきくけこ\nさしすせそ"
		var cnt = 0
		
		Timer.scheduledTimer(
			withTimeInterval:0.3,
			repeats: true) { (tmr) in
				
				if cnt < strTitle.count {
					// 文字のサイズ変更
					self.lbTitle.font =
						UIFont.systemFont(ofSize: 280.0)
					
					// 1文字表示
					self.lbTitle.text =
						String(Array(strTitle)[cnt])
					
					// 再生
					AudioServicesPlaySystemSound(self.ssId01)
					
					cnt += 1
					
				} else {
					// 文字のサイズ変更
					self.lbTitle.font =
						UIFont.systemFont(ofSize: 40.0)

					// 全文字表示
					self.lbTitle.text = strTitle
					
					// 再生
					AudioServicesPlaySystemSound(self.ssId02)
					
					// タイマー停止
					tmr.invalidate()
					
					// 処理中フラグOFF
					self.flgPlay = false

				}
		}.fire()

	}

	// 初期処理
	func initSoundEffect() {
		
		// ファイルの参照
		let url01 = Bundle.main.url(forResource: "Sound01", withExtension: "mp3")
		let url02 = Bundle.main.url(forResource: "Sound02", withExtension: "mp3")

		// 準備
		AudioServicesCreateSystemSoundID(url01! as CFURL, &ssId01)
		AudioServicesCreateSystemSoundID(url02! as CFURL, &ssId02)

//		Timer.scheduledTimer(withTimeInterval: <#T##TimeInterval#>,
//							 repeats: <#T##Bool#>,
//							 block: <#T##(Timer) -> Void#>)　// クロージャー
	}
	
}

