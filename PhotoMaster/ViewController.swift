//
//  ViewController.swift
//  PhotoMaster
//
//  Created by 中山弘瑛 on 2018/04/14.
//  Copyright © 2018年 中山弘瑛. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    //写真展示用ImageView
    @IBOutlet var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //「カメラ」ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedCameraButton(){
        presentPickerController(sourceType: .camera)
        
    }
    
    //「アルバム」ボタンを押した時に呼ばれるメソッド
    @IBAction func onTappedAlbumButton(){
        presentPickerController(sourceType: .photoLibrary)
        
    }
    
    //カメラ、アルバムの呼び出しメソッド（カメラorアルバムのソースタイプが引数）
    func presentPickerController(sourceType: UIImagePickerControllerSourceType){
        if UIImagePickerController.isSourceTypeAvailable(sourceType){
            let picker = UIImagePickerController()
            picker.sourceType = sourceType
            picker.delegate = self
            self.present(picker, animated: true, completion: nil)
        }
    }
    

    
    //写真が選択された時に呼び起こされるメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        //画像を出力
        photoImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
    }
    
    //元の画像にテキストを合成するメソッド
    func drawText(image: UIImage) -> UIImage {
        //テキストの内容の設定
        let text = "LifeisTech!"
        
        //textFrontAttributes: 文字の特性[フォントとサイズ、カラー、スタイル]の設定
        let textFontAttributes = [
            NSAttributedStringKey.font: UIFont(name: "Arial", size: 120)!,
            NSAttributedStringKey.foregroundColor: UIColor.red
        ]
        
        //グラフィックコンテキスト生成　編集を開始
        UIGraphicsBeginImageContext(image.size)
        
        //読み込んだ写真を書き出す
        image.draw(in: CGRect(x: 0, y: 0,width: image.size.width, height: image.size.height))
        
        //定義　CGRect(x: [左からのx座標]px, width: [横の長さ]px , height: [縦の長さ]px)
        let margin: CGFloat = 5.0 //余白
        let textRect = CGRect(x: margin, y:margin, width: image.size.width - margin, height: image.size.height - margin)
        
        //textRectで指定した範囲にtextFontAttributesにしたがってtextを描き出す
        text.draw(in: textRect, withAttributes: textFontAttributes)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return newImage!
        
        //元の画像にイラストを合成するメソッド
        func drawMaskImage(image: UIImage) -> UIImage{
            
            //マスク画像の設定
            let maskImage = UIImage(named: "furo_ducky")!
            
            UIGraphicsBeginImageContext(image.size)
            
            image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
            
            let margin: CGFloat = 50.0
            let maskRect = CGRect(x: image.size.width - maskImage.size.width - margin,
                                  y: image.size.height - maskImage.size.height - margin,
                                  width: maskImage.size.width, height: maskImage.size.height)
            
            maskImage.draw(in: maskRect)
            
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return newImage!
            
            
        }
        
        
        
    }
        
        //「テキスト合成」ボタンを押した時に呼ばれるメソッド
        @IBAction func onTappedTextButton(){
            if photoImageView.image != nil {
                photoImageView.image = drawText(image: photoImageView.image!)
                } else {
                print("画像がありません")
            }
            
        }
        
        
    
            
        //「イラスト合成」ボタンを押した時に呼ばれるメソッド
        @IBAction func onTappedIllustButton(){
            if photoImageView.image != nil {
                photoImageView.image = drawMaskImage(image: photoImageView.image!)
            } else {
                print("画像がありません")
            }
            
        }
                
                
                
            

        
    
    
    

}
