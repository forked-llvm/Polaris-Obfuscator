#pragma once

#include "llvm/Transforms/Obfuscation/Pipeline.h"
#include "llvm/IR/PassManager.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Transforms/Obfuscation/AliasAccess.h"
#include "llvm/Transforms/Obfuscation/Flattening.h"
#include "llvm/Transforms/Obfuscation/GlobalsEncryption.h"
#include "llvm/Transforms/Obfuscation/IndirectBranch.h"
#include "llvm/Transforms/Obfuscation/IndirectCall.h"
#include "llvm/Transforms/Utils/LowerSwitch.h"
using namespace llvm;
using namespace polaris;

static cl::list<std::string> Passes("passes", cl::CommaSeparated, cl::Hidden,
                                    cl::desc("Obfuscation passes"));

struct LowerSwitchWrapper : LowerSwitchPass {
  static bool isRequired() { return true; }
};

ModulePassManager buildObfuscationPipeline() {
  ModulePassManager MPM;

  for (auto pass : Passes) {
    if (pass == "fla") {
      MPM.addPass(Flattening());
    } else if (pass == "gvenc") {
      MPM.addPass(GlobalsEncryption());
    } else if (pass == "indbr") {
      FunctionPassManager FPM;
      FPM.addPass(IndirectBranch());
      MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
    } else if (pass == "indcall") {
      FunctionPassManager FPM;
      FPM.addPass(IndirectCall());
      MPM.addPass(createModuleToFunctionPassAdaptor(std::move(FPM)));
    } else if (pass == "alias") {
      MPM.addPass(AliasAccess());
    }
  }

  return MPM;
}
