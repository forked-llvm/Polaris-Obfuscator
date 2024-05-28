#include "llvm/IR/Function.h"
#include <string>
#include <vector>
using namespace llvm;
namespace polaris {
std::string readAnnotate(Function &f);
unsigned int getUniqueNumber(std::vector<unsigned int> &rand_list);
void getRandomNoRepeat(unsigned upper_bound, unsigned size,
                       std::vector<unsigned> &result);
} // namespace polaris
