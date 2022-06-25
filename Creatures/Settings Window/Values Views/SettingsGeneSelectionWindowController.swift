/*******************************************************************************
 * The MIT License (MIT)
 *
 * Copyright (c) 2022 Jean-David Gadina - www.xs-labs.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ******************************************************************************/

import Cocoa

public class SettingsGeneSelectionWindowController: NSWindowController
{
    @IBOutlet private var stackView: NSStackView!
    
    private var geneClass: AnyClass
    private var settings:  Settings
    
    public private( set ) var values: [ String ]
    
    public init( gene: AnyClass, settings: Settings, values: [ String ] )
    {
        self.geneClass = gene
        self.settings  = settings
        self.values    = values
        
        super.init( window: nil )
    }
    
    required init?( coder: NSCoder )
    {
        nil
    }
    
    public override var windowNibName: NSNib.Name?
    {
        "SettingsGeneSelectionWindowController"
    }
    
    public override func windowDidLoad()
    {
        super.windowDidLoad()
        
        let checkboxes: [ NSView ] = GeneInfo.allGenes( settings: self.settings ).sorted
        {
            $0.name < $1.name
        }
        .filter
        {
            $0.geneClass != self.geneClass
        }
        .map
        {
            let name                         = String( describing: $0.geneClass )
            let checkbox                     = NSButton( checkboxWithTitle: $0.name, target: nil, action: nil )
            checkbox.controlSize             = .small
            checkbox.cell?.representedObject = $0
            checkbox.state                   = self.values.contains( name ) ? .on : .off
            checkbox.target                  = self
            checkbox.action                  = #selector( selectGene( _: ) )
            
            return checkbox
        }
        
        self.stackView.setViews( checkboxes, in: .leading )
    }
    
    @objc private func selectGene( _ sender: Any? )
    {
        guard let checkbox = sender as? NSButton, let gene = checkbox.cell?.representedObject as? GeneInfo else
        {
            NSSound.beep()
            
            return
        }
        
        let name = String( describing: gene.geneClass )
        
        if checkbox.state == .on
        {
            self.values.append( name )
        }
        else
        {
            self.values.removeAll { $0 == name }
        }
    }
    
    @IBAction private func cancel( _ sender: Any? )
    {
        guard let window = self.window?.sheetParent, let sheet = self.window else
        {
            NSSound.beep()
            
            return
        }
        
        window.endSheet( sheet, returnCode: .cancel )
    }
    
    @IBAction private func select( _ sender: Any? )
    {
        guard let window = self.window?.sheetParent, let sheet = self.window else
        {
            NSSound.beep()
            
            return
        }
        
        window.endSheet( sheet, returnCode: .OK )
    }
}