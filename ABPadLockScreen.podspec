Pod::Spec.new do |s|
  s.name         = "ABPadLockScreen"
  s.version      = "2.0"
  s.summary      = "ABPadLockScreen provides a simple keypad style unlock feature for your iPhone or iPad app."
  s.homepage     = "https://github.com/abury/ABPadLockScreen"
  s.license      = {
    :type => 'Open Source',
    :text => <<-LICENSE
This software is provided 'as-is', without any express or implied
warranty.In no event will the authors be held liable for any damages
arising from the use of this software.

Permission is granted to anyone to use this software for any purpose,
including commercial applications, and to alter it and redistribute it
freely, subject to the following restrictions:

1. The origin of this software must not be misrepresented; you must not
claim that you wrote the original software. If you use this software
in a product, an acknowledgment in the product documentation would be
appreciated but is not required.

2. Altered source versions must be plainly marked as such, and must not be
misrepresented as being the original software.

3. This notice may not be removed or altered from any source distribution.
             
    LICENSE
    }
  s.author       = { "Aron Bury" => "aron.bury@gmail.com" }
  s.source       = { :git => "git://github.com/abury/ABPadLockScreen.git", :tag => "2.0" }
  s.platform     = :ios
  s.source_files = 'ABPadLockScreen/**/*'
end
