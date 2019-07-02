#include "eudaq/FileReader.hh"
#include "eudaq/DataConverter.hh"

#include "TH1D.h"

using namespace eudaq;

int main() {
  std::cout << "Initializing FileReader" << std::endl;
  FileReaderUP reader_;

  try {
    std::string path = "run000394_caribou_190331102118.raw";
    reader_ = Factory<eudaq::FileReader>::MakeUnique(cstr2hash("native"), path);
  } catch(...) {
    std::cout << "eudaq::FileReader could not read the input file. Please verify that the path and file name are correct.";
    return 1;
  }

  if(reader_ == nullptr) {
    std::cout << "Could not initialize FileReader from factory" << std::endl;
    return 1;
  }

  std::cout << "Initialized FileReader" << std::endl;
  TH1D * h1 = new TH1D();

  size_t event_nr = 0;

  std::cout << "Starting event loop" << std::endl;
  do {

    auto evt = reader_->GetNextEvent();
    if(!evt) {
      break;
    }

    // if we have ADC data:
    // std::string adc_data = evt->GetTag("DAC_OUT", "");
    // double adc_value;
    // if(adc_data.length() > 0) {
    //   adc_value = stod(adc_data, nullptr);
    //   LOG(DEBUG) << "ADC_DATA was " << adc_value;

  } while (1);

  return 0;
}
