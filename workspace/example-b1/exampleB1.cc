#include "G4RunManagerFactory.hh"
#include "G4UImanager.hh"
#include "G4VModularPhysicsList.hh"
#include "FTFP_BERT.hh"
#include "G4VisExecutive.hh"
#include "G4UIExecutive.hh"
#include "G4NistManager.hh"
#include "G4Box.hh"
#include "G4LogicalVolume.hh"
#include "G4PVPlacement.hh"
#include "G4SystemOfUnits.hh"
#include "G4VUserDetectorConstruction.hh"

class DummyDetector : public G4VUserDetectorConstruction {
public:
    G4VPhysicalVolume* Construct() override {
        auto nist = G4NistManager::Instance();
        auto solid = new G4Box("Box", 1*cm, 1*cm, 1*cm);
        auto logic = new G4LogicalVolume(solid, nist->FindOrBuildMaterial("G4_AIR"), "Logic");
        return new G4PVPlacement(nullptr, {}, logic, "Phys", nullptr, false, 0);
    }
};

int main(int argc, char** argv) {
    auto runManager = G4RunManagerFactory::CreateRunManager();
    runManager->SetUserInitialization(new DummyDetector());
    runManager->SetUserInitialization(new FTFP_BERT());

    auto visManager = new G4VisExecutive();
    visManager->Initialize();

    auto uiManager = G4UImanager::GetUIpointer();
    G4UIExecutive* ui = nullptr;
    if (argc == 1) {
        ui = new G4UIExecutive(argc, argv);
    }

    uiManager->ApplyCommand("/run/initialize");
    uiManager->ApplyCommand("/vis/open OGL");
    uiManager->ApplyCommand("/vis/drawVolume");
    uiManager->ApplyCommand("/vis/viewer/set/viewpointThetaPhi 70 20");
    uiManager->ApplyCommand("/vis/scene/add/axes 0 0 0 1");
    uiManager->ApplyCommand("/vis/sceneHandler/attach");

    if (ui) {
        ui->SessionStart();
        delete ui;
    }

    delete visManager;
    delete runManager;
    return 0;
}
