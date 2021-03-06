//
//  GeneralPreferencesViewController.swift
//  WWDC
//
//  Created by Guilherme Rambo on 28/05/17.
//  Copyright © 2017 Guilherme Rambo. All rights reserved.
//

import Cocoa

class GeneralPreferencesViewController: NSViewController {
    
    static func loadFromStoryboard() -> GeneralPreferencesViewController {
        let vc = NSStoryboard(name: "Preferences", bundle: nil).instantiateController(withIdentifier: "GeneralPreferencesViewController")
        
        return vc as! GeneralPreferencesViewController
    }
    
    @IBOutlet weak var searchInTranscriptsSwitch: ITSwitch!
    @IBOutlet weak var searchInBookmarksSwitch: ITSwitch!
    @IBOutlet weak var refreshPeriodicallySwitch: ITSwitch!
    
    @IBOutlet weak var downloadsFolderLabel: NSTextField!
    
    @IBOutlet weak var downloadsFolderIntroLabel: NSTextField!
    @IBOutlet weak var searchIntroLabel: NSTextField!
    @IBOutlet weak var includeBookmarksLabel: NSTextField!
    @IBOutlet weak var includeTranscriptsLabel: NSTextField!
    @IBOutlet weak var refreshAutomaticallyLabel: NSTextField!
    
    @IBOutlet weak var dividerA: NSBox!
    @IBOutlet weak var dividerB: NSBox!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadsFolderIntroLabel.textColor = .prefsPrimaryText
        searchIntroLabel.textColor = .prefsPrimaryText
        includeBookmarksLabel.textColor = .prefsPrimaryText
        includeTranscriptsLabel.textColor = .prefsPrimaryText
        refreshAutomaticallyLabel.textColor = .prefsPrimaryText
        downloadsFolderLabel.textColor = .prefsSecondaryText
        
        dividerA.fillColor = .darkGridColor
        dividerB.fillColor = .darkGridColor
        
        searchInTranscriptsSwitch.tintColor = .primary
        searchInBookmarksSwitch.tintColor = .primary
        refreshPeriodicallySwitch.tintColor = .primary
        
        searchInTranscriptsSwitch.checked = Preferences.shared.searchInTranscripts
        searchInBookmarksSwitch.checked = Preferences.shared.searchInBookmarks
        refreshPeriodicallySwitch.checked = Preferences.shared.refreshPeriodically
        
        downloadsFolderLabel.stringValue = Preferences.shared.localVideoStorageURL.path
    }
    
    @IBAction func searchInTranscriptsSwitchAction(_ sender: Any) {
        Preferences.shared.searchInTranscripts = searchInTranscriptsSwitch.checked
    }
    
    @IBAction func searchInBookmarksSwitchAction(_ sender: Any) {
        Preferences.shared.searchInBookmarks = searchInBookmarksSwitch.checked
    }
    
    @IBAction func refreshPeriodicallySwitchAction(_ sender: Any) {
        Preferences.shared.refreshPeriodically = refreshPeriodicallySwitch.checked
    }
    
    @IBAction func revealDownloadsFolderInFinder(_ sender: NSButton) {
        let url = Preferences.shared.localVideoStorageURL
        NSWorkspace.shared().selectFile(nil, inFileViewerRootedAtPath: url.path)
    }
    
    @IBAction func selectDownloadsFolder(_ sender: NSButton) {
        let panel = NSOpenPanel()
        
        panel.title = "Change Downloads Folder"
        panel.prompt = "Select"
        panel.canChooseDirectories = true
        panel.canChooseFiles = false
        
        panel.runModal()
        
        guard let url = panel.url else { return }
        
        Preferences.shared.localVideoStorageURL = url
        downloadsFolderLabel.stringValue = url.path
    }
    
}
