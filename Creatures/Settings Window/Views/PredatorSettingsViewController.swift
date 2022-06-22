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

public class PredatorSettingsViewController: SettingsViewController
{
    public init( settings: Settings )
    {
        super.init( title: "Predator", settings: settings, enabled: \.predator.isEnabled )
    }
    
    required init?( coder: NSCoder )
    {
        nil
    }
    
    public override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.helpText = "Creatures evolving this gene will use other creatures as food source, killing them in the process.\nNote that predators won't attack other predators or related creatures, unless they've evolved the cannibal gene."
        
        self.addBox(
            title: "General",
            controllers:
            [
                SettingsBoolValueCheckboxViewController( title: "Activate gene at start", settings: self.settings, key: \.predator.isActive ),
                SettingsBoolValueCheckboxViewController( title: "Allow gene to regress",  settings: self.settings, key: \.predator.canRegress ),
            ]
        )
    }
}
