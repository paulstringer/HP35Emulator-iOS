# HP35Emulator-iOS
An emulation of the HP-35 Calculator with non-ui based Acceptance Testing using Fitnesse

To build and run the acceptance tests after a fresh clone follow these steps:

- Install the OCSlimProject dependancy which requires CocoaPods ([CocoaPods Install](https://cocoapods.org))
```
$ sudo gem install cocoapods (if required)
$ cd HP35Emulator-iOS-master
$ pod install
```
- Open HP35Calc.xcworkspace
- Select the HP35FitnesseHost target / scheme in Xcode
- Build (Apple-B)
- Go to this directory in your Terminal and launch Fitnesse
```
   ./LaunchFitnesse
```
- Click on HP-35 Operating Manual
