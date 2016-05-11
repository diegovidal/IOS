//
//  CoreHome.swift
//  HomeKitDemo
//
//  Created by Ricardo Torquato Tavares on 30/06/15.
//  Copyright (c) 2015 com.br.bepid. All rights reserved.
//

import HomeKit

private let _sharedInstance = CoreHome()

let HomeKitUUIDs = [
    HMServiceTypeLightbulb:"Light Bulb",
    HMServiceTypeSwitch:"Switch",
    HMServiceTypeThermostat:"Thermostat",
    HMServiceTypeGarageDoorOpener:"Garage Door Opener",
    HMServiceTypeAccessoryInformation:"Accessory Information",
    HMServiceTypeFan:"Fan",
    HMServiceTypeOutlet:"Outlet",
    HMServiceTypeLockMechanism:"Lock Mechanism",
    HMServiceTypeLockManagement:"Lock Management",
    HMCharacteristicTypePowerState:"Power State",
    HMCharacteristicTypeHue:"Hue",
    HMCharacteristicTypeSaturation:"Saturation",
    HMCharacteristicTypeBrightness:"Brightness",
    HMCharacteristicTypeTemperatureUnits:"Temperature Units",
    HMCharacteristicTypeCurrentTemperature:"Current Temperature",
    HMCharacteristicTypeTargetTemperature:"Target Temperature",
    HMCharacteristicTypeCurrentHeatingCooling:"Current Heating Cooling",
    HMCharacteristicTypeTargetHeatingCooling:"Target Heating Cooling",
    HMCharacteristicTypeCoolingThreshold:"Cooling Threshold",
    HMCharacteristicTypeHeatingThreshold:"Heating Threshold",
    HMCharacteristicTypeCurrentRelativeHumidity:"Current Relative Humidity",
    HMCharacteristicTypeTargetRelativeHumidity:"Target Relative Humidity",
    HMCharacteristicTypeCurrentDoorState:"Current Door State",
    HMCharacteristicTypeTargetDoorState:"Target Door State",
    HMCharacteristicTypeObstructionDetected:"Obstruction Detected",
    HMCharacteristicTypeName:"Name",
    HMCharacteristicTypeManufacturer:"Manufacturer",
    HMCharacteristicTypeModel:"Model",
    HMCharacteristicTypeSerialNumber:"Serial Number",
    HMCharacteristicTypeIdentify:"Identify",
    HMCharacteristicTypeRotationDirection:"Rotation Direction",
    HMCharacteristicTypeRotationSpeed:"Rotation Speed",
    HMCharacteristicTypeOutletInUse:"Outlet In Use",
    HMCharacteristicTypeVersion:"Version",
    HMCharacteristicTypeLogs:"Logs",
    HMCharacteristicTypeAudioFeedback:"Audio Feedback",
    HMCharacteristicTypeAdminOnlyAccess:"Admin Only Access",
    HMCharacteristicTypeMotionDetected:"Motion Detected",
    HMCharacteristicTypeCurrentLockMechanismState:"Current Lock Mechanism State",
    HMCharacteristicTypeTargetLockMechanismState:"Target Lock Mechanism State",
    HMCharacteristicTypeLockMechanismLastKnownAction:"Lock Mechanism Last Known Action",
    HMCharacteristicTypeLockManagementControlPoint:"Lock Management Control Point",
    HMCharacteristicTypeLockManagementAutoSecureTimeout:"Lock Management Auto Secure Timeout"
]

class CoreHome {
    
    class var sharedInstance: CoreHome {
    return _sharedInstance
    }
    
    var homePrimary: HMHome?
    
    
}
