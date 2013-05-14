Pod::Spec.new do |s|
  s.name         = "AFMandrill"
  s.version      = '0.0.1'
  s.summary      = "Cocoa Interface for Mandrill"
  s.license      = 'MIT'
  s.homepage     = "https://github.com/ngs/AFMandrill"
  s.author       = {
    "Atsushi Nagase" => "a@ngs.io"
  }
  s.source         = { :git => 'https://github.com/ngs/AFMandrill.git', :tag => '0.0.1' }
  s.requires_arc = true
  s.platform     = :ios, '5.0'
  s.source_files = 'AFMandrill/*.{h,m}'
  s.frameworks = 'MobileCoreServices', 'SystemConfiguration'
  s.prefix_header_contents = <<-EOS
#import <Availability.h>
#if __IPHONE_OS_VERSION_MIN_REQUIRED
  #import <SystemConfiguration/SystemConfiguration.h>
  #import <MobileCoreServices/MobileCoreServices.h>
#else
  #import <SystemConfiguration/SystemConfiguration.h>
  #import <CoreServices/CoreServices.h>
#endif
EOS
end
