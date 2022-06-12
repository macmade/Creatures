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

public class SpriteNode: SKSpriteNode
{
    private static let flashActionKey = "Flash"
    
    public private( set ) var isBeingRemoved = false
    
    public func flash( _ flash: Bool )
    {
        self.alpha = 1
        
        if flash && self.action( forKey: SpriteNode.flashActionKey ) == nil
        {
            let fadeOut = SKAction.fadeOut( withDuration: 0.5 )
            let fadeIn  = SKAction.fadeIn(  withDuration: 0.5 )
            let flash   = SKAction.sequence( [ fadeOut, fadeIn ] )
            let group   = SKAction.repeatForever( flash )
            
            self.run( group, withKey: SpriteNode.flashActionKey )
        }
        else if flash == false
        {
            self.removeAction( forKey: SpriteNode.flashActionKey )
        }
    }
    
    public func remove()
    {
        self.isBeingRemoved = true
        self.physicsBody    = nil
        
        self.run( SKAction.fadeOut( withDuration: 0.5 ) )
        {
            self.removeFromParent()
        }
    }
}
