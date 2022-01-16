//
//  ViewController.swift
//  Audio
//
//  Created by 안수경 on 2022/01/16.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    //AVAudioPlayer 인스턴스 변수
    var audioPlayer: AVAudioPlayer!
    //재생할 오디오의 파일명 변수
    var audioFile: URL!
    //최대음량
    let MAX_VOLUME: Float = 10.0
    //타이머를 위한 변수
    var progressTimer: Timer!
    
    var timePlayerSelector: Selector = #selector(ViewController.updatePlayTime)
    
    var timeRecordSelector: Selector = #selector(ViewController.updateRecordTime)

    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var isRecordMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        selectAudioFile()
        
        if !isRecordMode{
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        } else{
          initRecord()
        }
    }
    
    func selectAudioFile(){
        if !isRecordMode{
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        }else{
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    func initRecord(){
        let recordSettings = [
            AVFormatIDKey: NSNumber(value: kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0] as [String: Any]
        do{
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError{
            print("Error-initRecord: \(error)")
        }
        audioRecorder.delegate = self
        
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(0)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        do{
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError{
            print("Error-setCategory: \(error)")
        }
        do{
            try session.setActive(true)
        } catch let error as NSError{
            print("Error-setActive: \(error)")
        }
        
        
    }
    
    //오디오 재생 초기화 과정, 녹음 초기화 과정을 분리.
    func initPlay(){
        //오디오 파일 불러오기
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay: \(error)")
        }
        // 볼륨 설정
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolume.value
        
        //time label 설정
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        
        //초기상태니까 0으로 초기화!
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        
        
        //재생, 일시정지, 정지 버튼 제어
        btnPlay.isEnabled = true
        btnPause.isEnabled = true
        btnStop.isEnabled = true
        
        setPlayButtons(true, pause: false, stop: false)
        
    }
    
    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool){
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    func convertNSTimeInterval2String(_ time: TimeInterval) -> String{
        //60으로 나눈 몫(분)
        let min = Int(time/60)
        
        //60으로 나눈 나머지(초)
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        //00:00 형식 으로 변환!!
        let strTime = String(format: "%02d:%02d", min, sec)
        return strTime
    }
    

    @IBAction func btnPlayAudio(_ sender: UIButton) {
        
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
        
    }
    
    
    //progress bar, current time label에 재생 시간 적용
    @objc func updatePlayTime(){
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime/audioPlayer.duration)
    }
    
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        
        setPlayButtons(true, pause: false, stop: false)
        
        //타이머 무효화
        progressTimer.invalidate()
    
    }
    
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
    
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn{
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        } else{
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2String(0)
        }
        selectAudioFile()
        if !isRecordMode{
            initPlay()
        } else{
            initRecord()
        }
    }
    
    @IBAction func btnRecord(_ sender: UIButton) {
        if (sender as AnyObject).titleLabel?.text == "Record"{
            audioRecorder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
            
        } else{
            audioRecorder.stop()
            progressTimer.invalidate()
            (sender as AnyObject).setTitle("Record", for:UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
        }
    }
    
    @objc func updateRecordTime(){
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }
}

