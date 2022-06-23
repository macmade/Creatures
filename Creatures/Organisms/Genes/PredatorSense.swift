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
import SpriteKit

public class PredatorSense: Gene
{
    public override var canRegress: Bool
    {
        self.settings.predatorSense.canRegress
    }
    
    public override var deactivates: [ String ]
    {
        self.settings.predatorSense.deactivates
    }
    
    public override var name: String
    {
        "Predator Sense"
    }
    
    public override var icon: NSImage?
    {
        NSImage( systemSymbolName: "sensor.tag.radiowaves.forward.fill", accessibilityDescription: nil )
    }
    
    public override func copy( with zone: NSZone? = nil ) -> Any
    {
        PredatorSense( active: self.isActive, settings: self.settings )
    }
    
    public override func chooseDestination( creature: Creature ) -> Destination?
    {
        let predicate: ( Creature ) -> Bool =
        {
            $0.hasActiveGene( Predator.self ) && PredationHelper.canBeEaten( creature: creature, by: $0 )
        }
        
        if let nearest: Creature = DistanceHelper.nearestObject( creature: creature, maxDistance: 100, predicate: predicate )
        {
            return Destination( point: DistanceHelper.opposite( of: nearest.position, from: creature.position ), priority: .high )
        }
        
        return nil
    }
}
