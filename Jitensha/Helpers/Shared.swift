//
//  Shared.swift
//  Jitensha
//
//  Created by Bassem Abbas on 6/7/17.
//  Copyright © 2017 Bassem Abbas. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
import Localize_Swift
import PKHUD
import ObjectMapper
import PopupDialog



var AppDefaultsAuthorized                                                                                                                = UserDefaults(suiteName: "com.EMBassem.Jitensha.Authorized")!;
var AppDefault                                                                                                                           = UserDefaults.standard;
var APP_DELEGATE                                                                                                                         = UIApplication.shared.delegate as! AppDelegate


class Shared {





class func Alert (_ title: String, message: String, confirmTitle: String, IsCansle: Bool                                                 = false, sender: UIViewController) {


let alertController                                                                                                                      = UIAlertController(title: title, message: message, preferredStyle: .alert)

let defaultAction                                                                                                                        = UIAlertAction(title: confirmTitle, style: .default, handler: nil)
        alertController.addAction(defaultAction)
        UIApplication.present(alertController, animated: true)


    }


    class HUD {


class func progressHUD (_ title: String?, message: String?, hideafter: Int?                                                              = nil, userInteraction: Bool = false) {

PKHUD.sharedHUD.contentView                                                                                                              = PKHUDProgressView(title: title, subtitle: message);
            PKHUD.sharedHUD.show();
            if (hideafter != nil) {
                PKHUD.sharedHUD.hide(afterDelay: TimeInterval(hideafter!));
            }

PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled                                                                                  = userInteraction;


        }

class func successHUD (_ title: String?, message: String?, hideafter: Int?                                                               = nil) {

PKHUD.sharedHUD.contentView                                                                                                              = PKHUDSuccessView(title: title, subtitle: message);
            PKHUD.sharedHUD.show();
            if (hideafter != nil) {
                PKHUD.sharedHUD.hide(afterDelay: TimeInterval(hideafter!));
            }
        }

class func ErrorHUD (_ title: String?, message: String?, hideafter: Int?                                                                 = nil) {

PKHUD.sharedHUD.contentView                                                                                                              = PKHUDErrorView(title: title, subtitle: message);
            PKHUD.sharedHUD.show();
            if (hideafter != nil) {
                PKHUD.sharedHUD.hide(afterDelay: TimeInterval(hideafter!));
            }
        }




class func hide (_ after: Int?                                                                                                           = nil) {


            if (after == nil) {
                PKHUD.sharedHUD.hide(true);
            } else {
                PKHUD.sharedHUD.hide(afterDelay: TimeInterval(after!));
            }
        }


    }


    class AlertDialog
    {

class func alertWithDismiss(_ title: String?, message: String?, image: UIImage?, cancelTitleKey: String, cancelCompletion: (() -> Void)? = nil) {



            // Create the dialog
//             let popup = PopupDialog
let popup                                                                                                                                = PopupDialog(title: title, message: message, image: image, buttonAlignment: UILayoutConstraintAxis.vertical, transitionStyle: PopupDialogTransitionStyle.bounceUp, gestureDismissal: false, completion: nil)

            // Create first button
let buttonOne                                                                                                                            = CancelButton(title: cancelTitleKey) {
                if (cancelCompletion != nil) {
                    cancelCompletion!();
                }
            }




            popup.addButtons([buttonOne])


            UIApplication.present(popup, animated: true);


        }




    }

    class Functions {

        class func callPhone(_ number: String) -> Bool {
if let phoneCallURL: URL                                                                                                                 = URL(string: "tel://\(number)") {
let application: UIApplication                                                                                                           = UIApplication.shared
                if (application.canOpenURL(phoneCallURL)) {
                    application.openURL(phoneCallURL);
                }
                return true;
            } else {

                Shared.AlertDialog.alertWithDismiss("SORRY".localized(), message: "FAILED_To_CALL".localized(), image: nil, cancelTitleKey: "CANCEL".localized(), cancelCompletion: nil)



                return false;
            }


        }

        class func openUrl(_ stringURL: String?) -> Bool {


if let urlString                                                                                                                         = stringURL {
if let url                                                                                                                               = URL(string: urlString) {
                    if UIApplication.shared.canOpenURL(url)
                        {
                        UIApplication.shared.openURL(url)
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;

                }
            } else {
                return false;
            }

        }


    }

    class Image {

        class func scaleImage (_ oldImage: UIImage?, width: Int?) -> UIImage? {
if let cgImage                                                                                                                           = oldImage?.cgImage {

let nwidth                                                                                                                               = width ?? cgImage.width / 2
let nheight                                                                                                                              = ( cgImage.height * width! / cgImage.width) ?? cgImage.height / 2
let bitsPerComponent                                                                                                                     = cgImage.bitsPerComponent
let bytesPerRow                                                                                                                          = cgImage.bytesPerRow
let colorSpace                                                                                                                           = cgImage.colorSpace
let bitmapInfo                                                                                                                           = cgImage.bitmapInfo

if let context                                                                                                                           = CGContext(data: nil, width: width!, height: nheight, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace!, bitmapInfo: bitmapInfo.rawValue) {

context.interpolationQuality                                                                                                             = CGInterpolationQuality.medium;

                    context.draw(cgImage, in: CGRect(origin: CGPoint.zero, size: CGSize(width: CGFloat(nwidth), height: CGFloat(nheight))));

let scaledImage                                                                                                                          = context.makeImage().flatMap { UIImage(cgImage: $0) }
                    return scaledImage
                }
            }


            return nil

        }

    }


}



