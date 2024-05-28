#include "llvm/Transforms/Obfuscation/Utils.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/CFG.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Instruction.h"
#include <algorithm>
#include <ctime>
#include <random>
using namespace llvm;
namespace polaris {
std::string readAnnotate(Function &f) {
  std::string annotation = "";
  GlobalVariable *glob =
      f.getParent()->getGlobalVariable("llvm.global.annotations");
  if (glob != NULL) {
    if (ConstantArray *ca = dyn_cast<ConstantArray>(glob->getInitializer())) {
      for (unsigned i = 0; i < ca->getNumOperands(); ++i) {
        if (ConstantStruct *structAn =
                dyn_cast<ConstantStruct>(ca->getOperand(i))) {
          if (structAn->getOperand(0) == &f) {
            if (GlobalVariable *annoteStr =
                    dyn_cast<GlobalVariable>(structAn->getOperand(1))) {
              if (ConstantDataSequential *data =
                      dyn_cast<ConstantDataSequential>(
                          annoteStr->getInitializer())) {
                if (data->isString()) {
                  annotation += data->getAsString().lower() + " ";
                }
              }
            }
          }
          // structAn->dump();
        }
      }
    }
  }
  return (annotation);
}

unsigned int getUniqueNumber(std::vector<unsigned int> &rand_list) {
  unsigned int num = rand();
  while (true) {
    bool state = true;
    for (auto n = rand_list.begin(); n != rand_list.end(); n++) {
      if (*n == num) {
        state = false;
        break;
      }
    }

    if (state)
      break;
    num = rand();
  }
  return num;
}

void getRandomNoRepeat(unsigned upper_bound, unsigned size,
                       std::vector<unsigned> &result) {
  assert(upper_bound >= size);
  std::vector<unsigned> list;
  for (unsigned i = 0; i < upper_bound; i++) {
    list.push_back(i);
  }

  std::shuffle(list.begin(), list.end(), std::default_random_engine());
  for (unsigned i = 0; i < size; i++) {
    result.push_back(list[i]);
  }
}
} // namespace polaris