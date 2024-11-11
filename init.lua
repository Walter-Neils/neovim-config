
local ____modules = {}
local ____moduleCache = {}
local ____originalRequire = require
local function require(file, ...)
    if ____moduleCache[file] then
        return ____moduleCache[file].value
    end
    if ____modules[file] then
        local module = ____modules[file]
        local value = nil
        if (select("#", ...) > 0) then value = module(...) else value = module(file) end
        ____moduleCache[file] = { value = value }
        return value
    else
        if ____originalRequire then
            return ____originalRequire(file)
        else
            error("module '" .. file .. "' not found")
        end
    end
end
____modules = {
["lualib_bundle"] = function(...) 
local function __TS__ArrayAt(self, relativeIndex)
    local absoluteIndex = relativeIndex < 0 and #self + relativeIndex or relativeIndex
    if absoluteIndex >= 0 and absoluteIndex < #self then
        return self[absoluteIndex + 1]
    end
    return nil
end

local function __TS__ArrayIsArray(value)
    return type(value) == "table" and (value[1] ~= nil or next(value) == nil)
end

local function __TS__ArrayConcat(self, ...)
    local items = {...}
    local result = {}
    local len = 0
    for i = 1, #self do
        len = len + 1
        result[len] = self[i]
    end
    for i = 1, #items do
        local item = items[i]
        if __TS__ArrayIsArray(item) then
            for j = 1, #item do
                len = len + 1
                result[len] = item[j]
            end
        else
            len = len + 1
            result[len] = item
        end
    end
    return result
end

local __TS__Symbol, Symbol
do
    local symbolMetatable = {__tostring = function(self)
        return ("Symbol(" .. (self.description or "")) .. ")"
    end}
    function __TS__Symbol(description)
        return setmetatable({description = description}, symbolMetatable)
    end
    Symbol = {
        asyncDispose = __TS__Symbol("Symbol.asyncDispose"),
        dispose = __TS__Symbol("Symbol.dispose"),
        iterator = __TS__Symbol("Symbol.iterator"),
        hasInstance = __TS__Symbol("Symbol.hasInstance"),
        species = __TS__Symbol("Symbol.species"),
        toStringTag = __TS__Symbol("Symbol.toStringTag")
    }
end

local function __TS__ArrayEntries(array)
    local key = 0
    return {
        [Symbol.iterator] = function(self)
            return self
        end,
        next = function(self)
            local result = {done = array[key + 1] == nil, value = {key, array[key + 1]}}
            key = key + 1
            return result
        end
    }
end

local function __TS__ArrayEvery(self, callbackfn, thisArg)
    for i = 1, #self do
        if not callbackfn(thisArg, self[i], i - 1, self) then
            return false
        end
    end
    return true
end

local function __TS__ArrayFill(self, value, start, ____end)
    local relativeStart = start or 0
    local relativeEnd = ____end or #self
    if relativeStart < 0 then
        relativeStart = relativeStart + #self
    end
    if relativeEnd < 0 then
        relativeEnd = relativeEnd + #self
    end
    do
        local i = relativeStart
        while i < relativeEnd do
            self[i + 1] = value
            i = i + 1
        end
    end
    return self
end

local function __TS__ArrayFilter(self, callbackfn, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            len = len + 1
            result[len] = self[i]
        end
    end
    return result
end

local function __TS__ArrayForEach(self, callbackFn, thisArg)
    for i = 1, #self do
        callbackFn(thisArg, self[i], i - 1, self)
    end
end

local function __TS__ArrayFind(self, predicate, thisArg)
    for i = 1, #self do
        local elem = self[i]
        if predicate(thisArg, elem, i - 1, self) then
            return elem
        end
    end
    return nil
end

local function __TS__ArrayFindIndex(self, callbackFn, thisArg)
    for i = 1, #self do
        if callbackFn(thisArg, self[i], i - 1, self) then
            return i - 1
        end
    end
    return -1
end

local __TS__Iterator
do
    local function iteratorGeneratorStep(self)
        local co = self.____coroutine
        local status, value = coroutine.resume(co)
        if not status then
            error(value, 0)
        end
        if coroutine.status(co) == "dead" then
            return
        end
        return true, value
    end
    local function iteratorIteratorStep(self)
        local result = self:next()
        if result.done then
            return
        end
        return true, result.value
    end
    local function iteratorStringStep(self, index)
        index = index + 1
        if index > #self then
            return
        end
        return index, string.sub(self, index, index)
    end
    function __TS__Iterator(iterable)
        if type(iterable) == "string" then
            return iteratorStringStep, iterable, 0
        elseif iterable.____coroutine ~= nil then
            return iteratorGeneratorStep, iterable
        elseif iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            return iteratorIteratorStep, iterator
        else
            return ipairs(iterable)
        end
    end
end

local __TS__ArrayFrom
do
    local function arrayLikeStep(self, index)
        index = index + 1
        if index > self.length then
            return
        end
        return index, self[index]
    end
    local function arrayLikeIterator(arr)
        if type(arr.length) == "number" then
            return arrayLikeStep, arr, 0
        end
        return __TS__Iterator(arr)
    end
    function __TS__ArrayFrom(arrayLike, mapFn, thisArg)
        local result = {}
        if mapFn == nil then
            for ____, v in arrayLikeIterator(arrayLike) do
                result[#result + 1] = v
            end
        else
            for i, v in arrayLikeIterator(arrayLike) do
                result[#result + 1] = mapFn(thisArg, v, i - 1)
            end
        end
        return result
    end
end

local function __TS__ArrayIncludes(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    local k = fromIndex
    if fromIndex < 0 then
        k = len + fromIndex
    end
    if k < 0 then
        k = 0
    end
    for i = k + 1, len do
        if self[i] == searchElement then
            return true
        end
    end
    return false
end

local function __TS__ArrayIndexOf(self, searchElement, fromIndex)
    if fromIndex == nil then
        fromIndex = 0
    end
    local len = #self
    if len == 0 then
        return -1
    end
    if fromIndex >= len then
        return -1
    end
    if fromIndex < 0 then
        fromIndex = len + fromIndex
        if fromIndex < 0 then
            fromIndex = 0
        end
    end
    for i = fromIndex + 1, len do
        if self[i] == searchElement then
            return i - 1
        end
    end
    return -1
end

local function __TS__ArrayJoin(self, separator)
    if separator == nil then
        separator = ","
    end
    local parts = {}
    for i = 1, #self do
        parts[i] = tostring(self[i])
    end
    return table.concat(parts, separator)
end

local function __TS__ArrayMap(self, callbackfn, thisArg)
    local result = {}
    for i = 1, #self do
        result[i] = callbackfn(thisArg, self[i], i - 1, self)
    end
    return result
end

local function __TS__ArrayPush(self, ...)
    local items = {...}
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

local function __TS__ArrayPushArray(self, items)
    local len = #self
    for i = 1, #items do
        len = len + 1
        self[len] = items[i]
    end
    return len
end

local function __TS__CountVarargs(...)
    return select("#", ...)
end

local function __TS__ArrayReduce(self, callbackFn, ...)
    local len = #self
    local k = 0
    local accumulator = nil
    if __TS__CountVarargs(...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[1]
        k = 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, len do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
end

local function __TS__ArrayReduceRight(self, callbackFn, ...)
    local len = #self
    local k = len - 1
    local accumulator = nil
    if __TS__CountVarargs(...) ~= 0 then
        accumulator = ...
    elseif len > 0 then
        accumulator = self[k + 1]
        k = k - 1
    else
        error("Reduce of empty array with no initial value", 0)
    end
    for i = k + 1, 1, -1 do
        accumulator = callbackFn(
            nil,
            accumulator,
            self[i],
            i - 1,
            self
        )
    end
    return accumulator
end

local function __TS__ArrayReverse(self)
    local i = 1
    local j = #self
    while i < j do
        local temp = self[j]
        self[j] = self[i]
        self[i] = temp
        i = i + 1
        j = j - 1
    end
    return self
end

local function __TS__ArrayUnshift(self, ...)
    local items = {...}
    local numItemsToInsert = #items
    if numItemsToInsert == 0 then
        return #self
    end
    for i = #self, 1, -1 do
        self[i + numItemsToInsert] = self[i]
    end
    for i = 1, numItemsToInsert do
        self[i] = items[i]
    end
    return #self
end

local function __TS__ArraySort(self, compareFn)
    if compareFn ~= nil then
        table.sort(
            self,
            function(a, b) return compareFn(nil, a, b) < 0 end
        )
    else
        table.sort(self)
    end
    return self
end

local function __TS__ArraySlice(self, first, last)
    local len = #self
    first = first or 0
    if first < 0 then
        first = len + first
        if first < 0 then
            first = 0
        end
    else
        if first > len then
            first = len
        end
    end
    last = last or len
    if last < 0 then
        last = len + last
        if last < 0 then
            last = 0
        end
    else
        if last > len then
            last = len
        end
    end
    local out = {}
    first = first + 1
    last = last + 1
    local n = 1
    while first < last do
        out[n] = self[first]
        first = first + 1
        n = n + 1
    end
    return out
end

local function __TS__ArraySome(self, callbackfn, thisArg)
    for i = 1, #self do
        if callbackfn(thisArg, self[i], i - 1, self) then
            return true
        end
    end
    return false
end

local function __TS__ArraySplice(self, ...)
    local args = {...}
    local len = #self
    local actualArgumentCount = __TS__CountVarargs(...)
    local start = args[1]
    local deleteCount = args[2]
    if start < 0 then
        start = len + start
        if start < 0 then
            start = 0
        end
    elseif start > len then
        start = len
    end
    local itemCount = actualArgumentCount - 2
    if itemCount < 0 then
        itemCount = 0
    end
    local actualDeleteCount
    if actualArgumentCount == 0 then
        actualDeleteCount = 0
    elseif actualArgumentCount == 1 then
        actualDeleteCount = len - start
    else
        actualDeleteCount = deleteCount or 0
        if actualDeleteCount < 0 then
            actualDeleteCount = 0
        end
        if actualDeleteCount > len - start then
            actualDeleteCount = len - start
        end
    end
    local out = {}
    for k = 1, actualDeleteCount do
        local from = start + k
        if self[from] ~= nil then
            out[k] = self[from]
        end
    end
    if itemCount < actualDeleteCount then
        for k = start + 1, len - actualDeleteCount do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
        for k = len - actualDeleteCount + itemCount + 1, len do
            self[k] = nil
        end
    elseif itemCount > actualDeleteCount then
        for k = len - actualDeleteCount, start + 1, -1 do
            local from = k + actualDeleteCount
            local to = k + itemCount
            if self[from] then
                self[to] = self[from]
            else
                self[to] = nil
            end
        end
    end
    local j = start + 1
    for i = 3, actualArgumentCount do
        self[j] = args[i]
        j = j + 1
    end
    for k = #self, len - actualDeleteCount + itemCount + 1, -1 do
        self[k] = nil
    end
    return out
end

local function __TS__ArrayToObject(self)
    local object = {}
    for i = 1, #self do
        object[i - 1] = self[i]
    end
    return object
end

local function __TS__ArrayFlat(self, depth)
    if depth == nil then
        depth = 1
    end
    local result = {}
    local len = 0
    for i = 1, #self do
        local value = self[i]
        if depth > 0 and __TS__ArrayIsArray(value) then
            local toAdd
            if depth == 1 then
                toAdd = value
            else
                toAdd = __TS__ArrayFlat(value, depth - 1)
            end
            for j = 1, #toAdd do
                local val = toAdd[j]
                len = len + 1
                result[len] = val
            end
        else
            len = len + 1
            result[len] = value
        end
    end
    return result
end

local function __TS__ArrayFlatMap(self, callback, thisArg)
    local result = {}
    local len = 0
    for i = 1, #self do
        local value = callback(thisArg, self[i], i - 1, self)
        if __TS__ArrayIsArray(value) then
            for j = 1, #value do
                len = len + 1
                result[len] = value[j]
            end
        else
            len = len + 1
            result[len] = value
        end
    end
    return result
end

local function __TS__ArraySetLength(self, length)
    if length < 0 or length ~= length or length == math.huge or math.floor(length) ~= length then
        error(
            "invalid array length: " .. tostring(length),
            0
        )
    end
    for i = length + 1, #self do
        self[i] = nil
    end
    return length
end

local __TS__Unpack = table.unpack or unpack

local function __TS__ArrayToReversed(self)
    local copy = {__TS__Unpack(self)}
    __TS__ArrayReverse(copy)
    return copy
end

local function __TS__ArrayToSorted(self, compareFn)
    local copy = {__TS__Unpack(self)}
    __TS__ArraySort(copy, compareFn)
    return copy
end

local function __TS__ArrayToSpliced(self, start, deleteCount, ...)
    local copy = {__TS__Unpack(self)}
    __TS__ArraySplice(copy, start, deleteCount, ...)
    return copy
end

local function __TS__ArrayWith(self, index, value)
    local copy = {__TS__Unpack(self)}
    copy[index + 1] = value
    return copy
end

local function __TS__New(target, ...)
    local instance = setmetatable({}, target.prototype)
    instance:____constructor(...)
    return instance
end

local function __TS__InstanceOf(obj, classTbl)
    if type(classTbl) ~= "table" then
        error("Right-hand side of 'instanceof' is not an object", 0)
    end
    if classTbl[Symbol.hasInstance] ~= nil then
        return not not classTbl[Symbol.hasInstance](classTbl, obj)
    end
    if type(obj) == "table" then
        local luaClass = obj.constructor
        while luaClass ~= nil do
            if luaClass == classTbl then
                return true
            end
            luaClass = luaClass.____super
        end
    end
    return false
end

local function __TS__Class(self)
    local c = {prototype = {}}
    c.prototype.__index = c.prototype
    c.prototype.constructor = c
    return c
end

local __TS__Promise
do
    local function makeDeferredPromiseFactory()
        local resolve
        local reject
        local function executor(____, res, rej)
            resolve = res
            reject = rej
        end
        return function()
            local promise = __TS__New(__TS__Promise, executor)
            return promise, resolve, reject
        end
    end
    local makeDeferredPromise = makeDeferredPromiseFactory()
    local function isPromiseLike(value)
        return __TS__InstanceOf(value, __TS__Promise)
    end
    local function doNothing(self)
    end
    local ____pcall = _G.pcall
    __TS__Promise = __TS__Class()
    __TS__Promise.name = "__TS__Promise"
    function __TS__Promise.prototype.____constructor(self, executor)
        self.state = 0
        self.fulfilledCallbacks = {}
        self.rejectedCallbacks = {}
        self.finallyCallbacks = {}
        local success, ____error = ____pcall(
            executor,
            nil,
            function(____, v) return self:resolve(v) end,
            function(____, err) return self:reject(err) end
        )
        if not success then
            self:reject(____error)
        end
    end
    function __TS__Promise.resolve(value)
        if __TS__InstanceOf(value, __TS__Promise) then
            return value
        end
        local promise = __TS__New(__TS__Promise, doNothing)
        promise.state = 1
        promise.value = value
        return promise
    end
    function __TS__Promise.reject(reason)
        local promise = __TS__New(__TS__Promise, doNothing)
        promise.state = 2
        promise.rejectionReason = reason
        return promise
    end
    __TS__Promise.prototype["then"] = function(self, onFulfilled, onRejected)
        local promise, resolve, reject = makeDeferredPromise()
        self:addCallbacks(
            onFulfilled and self:createPromiseResolvingCallback(onFulfilled, resolve, reject) or resolve,
            onRejected and self:createPromiseResolvingCallback(onRejected, resolve, reject) or reject
        )
        return promise
    end
    function __TS__Promise.prototype.addCallbacks(self, fulfilledCallback, rejectedCallback)
        if self.state == 1 then
            return fulfilledCallback(nil, self.value)
        end
        if self.state == 2 then
            return rejectedCallback(nil, self.rejectionReason)
        end
        local ____self_fulfilledCallbacks_0 = self.fulfilledCallbacks
        ____self_fulfilledCallbacks_0[#____self_fulfilledCallbacks_0 + 1] = fulfilledCallback
        local ____self_rejectedCallbacks_1 = self.rejectedCallbacks
        ____self_rejectedCallbacks_1[#____self_rejectedCallbacks_1 + 1] = rejectedCallback
    end
    function __TS__Promise.prototype.catch(self, onRejected)
        return self["then"](self, nil, onRejected)
    end
    function __TS__Promise.prototype.finally(self, onFinally)
        if onFinally then
            local ____self_finallyCallbacks_2 = self.finallyCallbacks
            ____self_finallyCallbacks_2[#____self_finallyCallbacks_2 + 1] = onFinally
            if self.state ~= 0 then
                onFinally(nil)
            end
        end
        return self
    end
    function __TS__Promise.prototype.resolve(self, value)
        if isPromiseLike(value) then
            return value:addCallbacks(
                function(____, v) return self:resolve(v) end,
                function(____, err) return self:reject(err) end
            )
        end
        if self.state == 0 then
            self.state = 1
            self.value = value
            return self:invokeCallbacks(self.fulfilledCallbacks, value)
        end
    end
    function __TS__Promise.prototype.reject(self, reason)
        if self.state == 0 then
            self.state = 2
            self.rejectionReason = reason
            return self:invokeCallbacks(self.rejectedCallbacks, reason)
        end
    end
    function __TS__Promise.prototype.invokeCallbacks(self, callbacks, value)
        local callbacksLength = #callbacks
        local finallyCallbacks = self.finallyCallbacks
        local finallyCallbacksLength = #finallyCallbacks
        if callbacksLength ~= 0 then
            for i = 1, callbacksLength - 1 do
                callbacks[i](callbacks, value)
            end
            if finallyCallbacksLength == 0 then
                return callbacks[callbacksLength](callbacks, value)
            end
            callbacks[callbacksLength](callbacks, value)
        end
        if finallyCallbacksLength ~= 0 then
            for i = 1, finallyCallbacksLength - 1 do
                finallyCallbacks[i](finallyCallbacks)
            end
            return finallyCallbacks[finallyCallbacksLength](finallyCallbacks)
        end
    end
    function __TS__Promise.prototype.createPromiseResolvingCallback(self, f, resolve, reject)
        return function(____, value)
            local success, resultOrError = ____pcall(f, nil, value)
            if not success then
                return reject(nil, resultOrError)
            end
            return self:handleCallbackValue(resultOrError, resolve, reject)
        end
    end
    function __TS__Promise.prototype.handleCallbackValue(self, value, resolve, reject)
        if isPromiseLike(value) then
            local nextpromise = value
            if nextpromise.state == 1 then
                return resolve(nil, nextpromise.value)
            elseif nextpromise.state == 2 then
                return reject(nil, nextpromise.rejectionReason)
            else
                return nextpromise:addCallbacks(resolve, reject)
            end
        else
            return resolve(nil, value)
        end
    end
end

local __TS__AsyncAwaiter, __TS__Await
do
    local ____coroutine = _G.coroutine or ({})
    local cocreate = ____coroutine.create
    local coresume = ____coroutine.resume
    local costatus = ____coroutine.status
    local coyield = ____coroutine.yield
    function __TS__AsyncAwaiter(generator)
        return __TS__New(
            __TS__Promise,
            function(____, resolve, reject)
                local fulfilled, step, resolved, asyncCoroutine
                function fulfilled(self, value)
                    local success, resultOrError = coresume(asyncCoroutine, value)
                    if success then
                        return step(resultOrError)
                    end
                    return reject(nil, resultOrError)
                end
                function step(result)
                    if resolved then
                        return
                    end
                    if costatus(asyncCoroutine) == "dead" then
                        return resolve(nil, result)
                    end
                    return __TS__Promise.resolve(result):addCallbacks(fulfilled, reject)
                end
                resolved = false
                asyncCoroutine = cocreate(generator)
                local success, resultOrError = coresume(
                    asyncCoroutine,
                    function(____, v)
                        resolved = true
                        return __TS__Promise.resolve(v):addCallbacks(resolve, reject)
                    end
                )
                if success then
                    return step(resultOrError)
                else
                    return reject(nil, resultOrError)
                end
            end
        )
    end
    function __TS__Await(thing)
        return coyield(thing)
    end
end

local function __TS__ClassExtends(target, base)
    target.____super = base
    local staticMetatable = setmetatable({__index = base}, base)
    setmetatable(target, staticMetatable)
    local baseMetatable = getmetatable(base)
    if baseMetatable then
        if type(baseMetatable.__index) == "function" then
            staticMetatable.__index = baseMetatable.__index
        end
        if type(baseMetatable.__newindex) == "function" then
            staticMetatable.__newindex = baseMetatable.__newindex
        end
    end
    setmetatable(target.prototype, base.prototype)
    if type(base.prototype.__index) == "function" then
        target.prototype.__index = base.prototype.__index
    end
    if type(base.prototype.__newindex) == "function" then
        target.prototype.__newindex = base.prototype.__newindex
    end
    if type(base.prototype.__tostring) == "function" then
        target.prototype.__tostring = base.prototype.__tostring
    end
end

local function __TS__CloneDescriptor(____bindingPattern0)
    local value
    local writable
    local set
    local get
    local configurable
    local enumerable
    enumerable = ____bindingPattern0.enumerable
    configurable = ____bindingPattern0.configurable
    get = ____bindingPattern0.get
    set = ____bindingPattern0.set
    writable = ____bindingPattern0.writable
    value = ____bindingPattern0.value
    local descriptor = {enumerable = enumerable == true, configurable = configurable == true}
    local hasGetterOrSetter = get ~= nil or set ~= nil
    local hasValueOrWritableAttribute = writable ~= nil or value ~= nil
    if hasGetterOrSetter and hasValueOrWritableAttribute then
        error("Invalid property descriptor. Cannot both specify accessors and a value or writable attribute.", 0)
    end
    if get or set then
        descriptor.get = get
        descriptor.set = set
    else
        descriptor.value = value
        descriptor.writable = writable == true
    end
    return descriptor
end

local function __TS__Decorate(self, originalValue, decorators, context)
    local result = originalValue
    do
        local i = #decorators
        while i >= 0 do
            local decorator = decorators[i + 1]
            if decorator ~= nil then
                local ____decorator_result_0 = decorator(self, result, context)
                if ____decorator_result_0 == nil then
                    ____decorator_result_0 = result
                end
                result = ____decorator_result_0
            end
            i = i - 1
        end
    end
    return result
end

local function __TS__ObjectAssign(target, ...)
    local sources = {...}
    for i = 1, #sources do
        local source = sources[i]
        for key in pairs(source) do
            target[key] = source[key]
        end
    end
    return target
end

local function __TS__ObjectGetOwnPropertyDescriptor(object, key)
    local metatable = getmetatable(object)
    if not metatable then
        return
    end
    if not rawget(metatable, "_descriptors") then
        return
    end
    return rawget(metatable, "_descriptors")[key]
end

local __TS__DescriptorGet
do
    local getmetatable = _G.getmetatable
    local ____rawget = _G.rawget
    function __TS__DescriptorGet(self, metatable, key)
        while metatable do
            local rawResult = ____rawget(metatable, key)
            if rawResult ~= nil then
                return rawResult
            end
            local descriptors = ____rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor ~= nil then
                    if descriptor.get then
                        return descriptor.get(self)
                    end
                    return descriptor.value
                end
            end
            metatable = getmetatable(metatable)
        end
    end
end

local __TS__DescriptorSet
do
    local getmetatable = _G.getmetatable
    local ____rawget = _G.rawget
    local rawset = _G.rawset
    function __TS__DescriptorSet(self, metatable, key, value)
        while metatable do
            local descriptors = ____rawget(metatable, "_descriptors")
            if descriptors then
                local descriptor = descriptors[key]
                if descriptor ~= nil then
                    if descriptor.set then
                        descriptor.set(self, value)
                    else
                        if descriptor.writable == false then
                            error(
                                ((("Cannot assign to read only property '" .. key) .. "' of object '") .. tostring(self)) .. "'",
                                0
                            )
                        end
                        descriptor.value = value
                    end
                    return
                end
            end
            metatable = getmetatable(metatable)
        end
        rawset(self, key, value)
    end
end

local __TS__SetDescriptor
do
    local getmetatable = _G.getmetatable
    local function descriptorIndex(self, key)
        return __TS__DescriptorGet(
            self,
            getmetatable(self),
            key
        )
    end
    local function descriptorNewIndex(self, key, value)
        return __TS__DescriptorSet(
            self,
            getmetatable(self),
            key,
            value
        )
    end
    function __TS__SetDescriptor(target, key, desc, isPrototype)
        if isPrototype == nil then
            isPrototype = false
        end
        local ____isPrototype_0
        if isPrototype then
            ____isPrototype_0 = target
        else
            ____isPrototype_0 = getmetatable(target)
        end
        local metatable = ____isPrototype_0
        if not metatable then
            metatable = {}
            setmetatable(target, metatable)
        end
        local value = rawget(target, key)
        if value ~= nil then
            rawset(target, key, nil)
        end
        if not rawget(metatable, "_descriptors") then
            metatable._descriptors = {}
        end
        metatable._descriptors[key] = __TS__CloneDescriptor(desc)
        metatable.__index = descriptorIndex
        metatable.__newindex = descriptorNewIndex
    end
end

local function __TS__DecorateLegacy(decorators, target, key, desc)
    local result = target
    do
        local i = #decorators
        while i >= 0 do
            local decorator = decorators[i + 1]
            if decorator ~= nil then
                local oldResult = result
                if key == nil then
                    result = decorator(nil, result)
                elseif desc == true then
                    local value = rawget(target, key)
                    local descriptor = __TS__ObjectGetOwnPropertyDescriptor(target, key) or ({configurable = true, writable = true, value = value})
                    local desc = decorator(nil, target, key, descriptor) or descriptor
                    local isSimpleValue = desc.configurable == true and desc.writable == true and not desc.get and not desc.set
                    if isSimpleValue then
                        rawset(target, key, desc.value)
                    else
                        __TS__SetDescriptor(
                            target,
                            key,
                            __TS__ObjectAssign({}, descriptor, desc)
                        )
                    end
                elseif desc == false then
                    result = decorator(nil, target, key, desc)
                else
                    result = decorator(nil, target, key)
                end
                result = result or oldResult
            end
            i = i - 1
        end
    end
    return result
end

local function __TS__DecorateParam(paramIndex, decorator)
    return function(____, target, key) return decorator(nil, target, key, paramIndex) end
end

local function __TS__StringIncludes(self, searchString, position)
    if not position then
        position = 1
    else
        position = position + 1
    end
    local index = string.find(self, searchString, position, true)
    return index ~= nil
end

local Error, RangeError, ReferenceError, SyntaxError, TypeError, URIError
do
    local function getErrorStack(self, constructor)
        if debug == nil then
            return nil
        end
        local level = 1
        while true do
            local info = debug.getinfo(level, "f")
            level = level + 1
            if not info then
                level = 1
                break
            elseif info.func == constructor then
                break
            end
        end
        if __TS__StringIncludes(_VERSION, "Lua 5.0") then
            return debug.traceback(("[Level " .. tostring(level)) .. "]")
        else
            return debug.traceback(nil, level)
        end
    end
    local function wrapErrorToString(self, getDescription)
        return function(self)
            local description = getDescription(self)
            local caller = debug.getinfo(3, "f")
            local isClassicLua = __TS__StringIncludes(_VERSION, "Lua 5.0") or _VERSION == "Lua 5.1"
            if isClassicLua or caller and caller.func ~= error then
                return description
            else
                return (description .. "\n") .. tostring(self.stack)
            end
        end
    end
    local function initErrorClass(self, Type, name)
        Type.name = name
        return setmetatable(
            Type,
            {__call = function(____, _self, message) return __TS__New(Type, message) end}
        )
    end
    local ____initErrorClass_1 = initErrorClass
    local ____class_0 = __TS__Class()
    ____class_0.name = ""
    function ____class_0.prototype.____constructor(self, message)
        if message == nil then
            message = ""
        end
        self.message = message
        self.name = "Error"
        self.stack = getErrorStack(nil, self.constructor.new)
        local metatable = getmetatable(self)
        if metatable and not metatable.__errorToStringPatched then
            metatable.__errorToStringPatched = true
            metatable.__tostring = wrapErrorToString(nil, metatable.__tostring)
        end
    end
    function ____class_0.prototype.__tostring(self)
        return self.message ~= "" and (self.name .. ": ") .. self.message or self.name
    end
    Error = ____initErrorClass_1(nil, ____class_0, "Error")
    local function createErrorClass(self, name)
        local ____initErrorClass_3 = initErrorClass
        local ____class_2 = __TS__Class()
        ____class_2.name = ____class_2.name
        __TS__ClassExtends(____class_2, Error)
        function ____class_2.prototype.____constructor(self, ...)
            ____class_2.____super.prototype.____constructor(self, ...)
            self.name = name
        end
        return ____initErrorClass_3(nil, ____class_2, name)
    end
    RangeError = createErrorClass(nil, "RangeError")
    ReferenceError = createErrorClass(nil, "ReferenceError")
    SyntaxError = createErrorClass(nil, "SyntaxError")
    TypeError = createErrorClass(nil, "TypeError")
    URIError = createErrorClass(nil, "URIError")
end

local function __TS__ObjectGetOwnPropertyDescriptors(object)
    local metatable = getmetatable(object)
    if not metatable then
        return {}
    end
    return rawget(metatable, "_descriptors") or ({})
end

local function __TS__Delete(target, key)
    local descriptors = __TS__ObjectGetOwnPropertyDescriptors(target)
    local descriptor = descriptors[key]
    if descriptor then
        if not descriptor.configurable then
            error(
                __TS__New(
                    TypeError,
                    ((("Cannot delete property " .. tostring(key)) .. " of ") .. tostring(target)) .. "."
                ),
                0
            )
        end
        descriptors[key] = nil
        return true
    end
    target[key] = nil
    return true
end

local function __TS__StringAccess(self, index)
    if index >= 0 and index < #self then
        return string.sub(self, index + 1, index + 1)
    end
end

local function __TS__DelegatedYield(iterable)
    if type(iterable) == "string" then
        for index = 0, #iterable - 1 do
            coroutine.yield(__TS__StringAccess(iterable, index))
        end
    elseif iterable.____coroutine ~= nil then
        local co = iterable.____coroutine
        while true do
            local status, value = coroutine.resume(co)
            if not status then
                error(value, 0)
            end
            if coroutine.status(co) == "dead" then
                return value
            else
                coroutine.yield(value)
            end
        end
    elseif iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                return result.value
            else
                coroutine.yield(result.value)
            end
        end
    else
        for ____, value in ipairs(iterable) do
            coroutine.yield(value)
        end
    end
end

local function __TS__FunctionBind(fn, ...)
    local boundArgs = {...}
    return function(____, ...)
        local args = {...}
        __TS__ArrayUnshift(
            args,
            __TS__Unpack(boundArgs)
        )
        return fn(__TS__Unpack(args))
    end
end

local __TS__Generator
do
    local function generatorIterator(self)
        return self
    end
    local function generatorNext(self, ...)
        local co = self.____coroutine
        if coroutine.status(co) == "dead" then
            return {done = true}
        end
        local status, value = coroutine.resume(co, ...)
        if not status then
            error(value, 0)
        end
        return {
            value = value,
            done = coroutine.status(co) == "dead"
        }
    end
    function __TS__Generator(fn)
        return function(...)
            local args = {...}
            local argsLength = __TS__CountVarargs(...)
            return {
                ____coroutine = coroutine.create(function() return fn(__TS__Unpack(args, 1, argsLength)) end),
                [Symbol.iterator] = generatorIterator,
                next = generatorNext
            }
        end
    end
end

local function __TS__InstanceOfObject(value)
    local valueType = type(value)
    return valueType == "table" or valueType == "function"
end

local function __TS__LuaIteratorSpread(self, state, firstKey)
    local results = {}
    local key, value = self(state, firstKey)
    while key do
        results[#results + 1] = {key, value}
        key, value = self(state, key)
    end
    return __TS__Unpack(results)
end

local Map
do
    Map = __TS__Class()
    Map.name = "Map"
    function Map.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "Map"
        self.items = {}
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self:set(value[1], value[2])
            end
        else
            local array = entries
            for ____, kvp in ipairs(array) do
                self:set(kvp[1], kvp[2])
            end
        end
    end
    function Map.prototype.clear(self)
        self.items = {}
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Map.prototype.delete(self, key)
        local contains = self:has(key)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[key]
            local previous = self.previousKey[key]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[key] = nil
            self.previousKey[key] = nil
        end
        self.items[key] = nil
        return contains
    end
    function Map.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, self.items[key], key, self)
        end
    end
    function Map.prototype.get(self, key)
        return self.items[key]
    end
    function Map.prototype.has(self, key)
        return self.nextKey[key] ~= nil or self.lastKey == key
    end
    function Map.prototype.set(self, key, value)
        local isNewValue = not self:has(key)
        if isNewValue then
            self.size = self.size + 1
        end
        self.items[key] = value
        if self.firstKey == nil then
            self.firstKey = key
            self.lastKey = key
        elseif isNewValue then
            self.nextKey[self.lastKey] = key
            self.previousKey[key] = self.lastKey
            self.lastKey = key
        end
        return self
    end
    Map.prototype[Symbol.iterator] = function(self)
        return self:entries()
    end
    function Map.prototype.entries(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, items[key]}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Map.prototype.values(self)
        local items = self.items
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = items[key]}
                key = nextKey[key]
                return result
            end
        }
    end
    Map[Symbol.species] = Map
end

local function __TS__MapGroupBy(items, keySelector)
    local result = __TS__New(Map)
    local i = 0
    for ____, item in __TS__Iterator(items) do
        local key = keySelector(nil, item, i)
        if result:has(key) then
            local ____temp_0 = result:get(key)
            ____temp_0[#____temp_0 + 1] = item
        else
            result:set(key, {item})
        end
        i = i + 1
    end
    return result
end

local __TS__Match = string.match

local __TS__MathAtan2 = math.atan2 or math.atan

local __TS__MathModf = math.modf

local function __TS__NumberIsNaN(value)
    return value ~= value
end

local function __TS__MathSign(val)
    if __TS__NumberIsNaN(val) or val == 0 then
        return val
    end
    if val < 0 then
        return -1
    end
    return 1
end

local function __TS__NumberIsFinite(value)
    return type(value) == "number" and value == value and value ~= math.huge and value ~= -math.huge
end

local function __TS__MathTrunc(val)
    if not __TS__NumberIsFinite(val) or val == 0 then
        return val
    end
    return val > 0 and math.floor(val) or math.ceil(val)
end

local function __TS__Number(value)
    local valueType = type(value)
    if valueType == "number" then
        return value
    elseif valueType == "string" then
        local numberValue = tonumber(value)
        if numberValue then
            return numberValue
        end
        if value == "Infinity" then
            return math.huge
        end
        if value == "-Infinity" then
            return -math.huge
        end
        local stringWithoutSpaces = string.gsub(value, "%s", "")
        if stringWithoutSpaces == "" then
            return 0
        end
        return 0 / 0
    elseif valueType == "boolean" then
        return value and 1 or 0
    else
        return 0 / 0
    end
end

local function __TS__NumberIsInteger(value)
    return __TS__NumberIsFinite(value) and math.floor(value) == value
end

local function __TS__StringSubstring(self, start, ____end)
    if ____end ~= ____end then
        ____end = 0
    end
    if ____end ~= nil and start > ____end then
        start, ____end = ____end, start
    end
    if start >= 0 then
        start = start + 1
    else
        start = 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = 0
    end
    return string.sub(self, start, ____end)
end

local __TS__ParseInt
do
    local parseIntBasePattern = "0123456789aAbBcCdDeEfFgGhHiIjJkKlLmMnNoOpPqQrRsStTvVwWxXyYzZ"
    function __TS__ParseInt(numberString, base)
        if base == nil then
            base = 10
            local hexMatch = __TS__Match(numberString, "^%s*-?0[xX]")
            if hexMatch ~= nil then
                base = 16
                numberString = (__TS__Match(hexMatch, "-")) and "-" .. __TS__StringSubstring(numberString, #hexMatch) or __TS__StringSubstring(numberString, #hexMatch)
            end
        end
        if base < 2 or base > 36 then
            return 0 / 0
        end
        local allowedDigits = base <= 10 and __TS__StringSubstring(parseIntBasePattern, 0, base) or __TS__StringSubstring(parseIntBasePattern, 0, 10 + 2 * (base - 10))
        local pattern = ("^%s*(-?[" .. allowedDigits) .. "]*)"
        local number = tonumber((__TS__Match(numberString, pattern)), base)
        if number == nil then
            return 0 / 0
        end
        if number >= 0 then
            return math.floor(number)
        else
            return math.ceil(number)
        end
    end
end

local function __TS__ParseFloat(numberString)
    local infinityMatch = __TS__Match(numberString, "^%s*(-?Infinity)")
    if infinityMatch ~= nil then
        return __TS__StringAccess(infinityMatch, 0) == "-" and -math.huge or math.huge
    end
    local number = tonumber((__TS__Match(numberString, "^%s*(-?%d+%.?%d*)")))
    return number or 0 / 0
end

local __TS__NumberToString
do
    local radixChars = "0123456789abcdefghijklmnopqrstuvwxyz"
    function __TS__NumberToString(self, radix)
        if radix == nil or radix == 10 or self == math.huge or self == -math.huge or self ~= self then
            return tostring(self)
        end
        radix = math.floor(radix)
        if radix < 2 or radix > 36 then
            error("toString() radix argument must be between 2 and 36", 0)
        end
        local integer, fraction = __TS__MathModf(math.abs(self))
        local result = ""
        if radix == 8 then
            result = string.format("%o", integer)
        elseif radix == 16 then
            result = string.format("%x", integer)
        else
            repeat
                do
                    result = __TS__StringAccess(radixChars, integer % radix) .. result
                    integer = math.floor(integer / radix)
                end
            until not (integer ~= 0)
        end
        if fraction ~= 0 then
            result = result .. "."
            local delta = 1e-16
            repeat
                do
                    fraction = fraction * radix
                    delta = delta * radix
                    local digit = math.floor(fraction)
                    result = result .. __TS__StringAccess(radixChars, digit)
                    fraction = fraction - digit
                end
            until not (fraction >= delta)
        end
        if self < 0 then
            result = "-" .. result
        end
        return result
    end
end

local function __TS__NumberToFixed(self, fractionDigits)
    if math.abs(self) >= 1e+21 or self ~= self then
        return tostring(self)
    end
    local f = math.floor(fractionDigits or 0)
    if f < 0 or f > 99 then
        error("toFixed() digits argument must be between 0 and 99", 0)
    end
    return string.format(
        ("%." .. tostring(f)) .. "f",
        self
    )
end

local function __TS__ObjectDefineProperty(target, key, desc)
    local luaKey = type(key) == "number" and key + 1 or key
    local value = rawget(target, luaKey)
    local hasGetterOrSetter = desc.get ~= nil or desc.set ~= nil
    local descriptor
    if hasGetterOrSetter then
        if value ~= nil then
            error(
                "Cannot redefine property: " .. tostring(key),
                0
            )
        end
        descriptor = desc
    else
        local valueExists = value ~= nil
        local ____desc_set_4 = desc.set
        local ____desc_get_5 = desc.get
        local ____temp_0
        if desc.configurable ~= nil then
            ____temp_0 = desc.configurable
        else
            ____temp_0 = valueExists
        end
        local ____temp_1
        if desc.enumerable ~= nil then
            ____temp_1 = desc.enumerable
        else
            ____temp_1 = valueExists
        end
        local ____temp_2
        if desc.writable ~= nil then
            ____temp_2 = desc.writable
        else
            ____temp_2 = valueExists
        end
        local ____temp_3
        if desc.value ~= nil then
            ____temp_3 = desc.value
        else
            ____temp_3 = value
        end
        descriptor = {
            set = ____desc_set_4,
            get = ____desc_get_5,
            configurable = ____temp_0,
            enumerable = ____temp_1,
            writable = ____temp_2,
            value = ____temp_3
        }
    end
    __TS__SetDescriptor(target, luaKey, descriptor)
    return target
end

local function __TS__ObjectEntries(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = {key, obj[key]}
    end
    return result
end

local function __TS__ObjectFromEntries(entries)
    local obj = {}
    local iterable = entries
    if iterable[Symbol.iterator] then
        local iterator = iterable[Symbol.iterator](iterable)
        while true do
            local result = iterator:next()
            if result.done then
                break
            end
            local value = result.value
            obj[value[1]] = value[2]
        end
    else
        for ____, entry in ipairs(entries) do
            obj[entry[1]] = entry[2]
        end
    end
    return obj
end

local function __TS__ObjectGroupBy(items, keySelector)
    local result = {}
    local i = 0
    for ____, item in __TS__Iterator(items) do
        local key = keySelector(nil, item, i)
        if result[key] ~= nil then
            local ____result_key_0 = result[key]
            ____result_key_0[#____result_key_0 + 1] = item
        else
            result[key] = {item}
        end
        i = i + 1
    end
    return result
end

local function __TS__ObjectKeys(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = key
    end
    return result
end

local function __TS__ObjectRest(target, usedProperties)
    local result = {}
    for property in pairs(target) do
        if not usedProperties[property] then
            result[property] = target[property]
        end
    end
    return result
end

local function __TS__ObjectValues(obj)
    local result = {}
    local len = 0
    for key in pairs(obj) do
        len = len + 1
        result[len] = obj[key]
    end
    return result
end

local function __TS__PromiseAll(iterable)
    local results = {}
    local toResolve = {}
    local numToResolve = 0
    local i = 0
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                results[i + 1] = item.value
            elseif item.state == 2 then
                return __TS__Promise.reject(item.rejectionReason)
            else
                numToResolve = numToResolve + 1
                toResolve[i] = item
            end
        else
            results[i + 1] = item
        end
        i = i + 1
    end
    if numToResolve == 0 then
        return __TS__Promise.resolve(results)
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for index, promise in pairs(toResolve) do
                promise["then"](
                    promise,
                    function(____, data)
                        results[index + 1] = data
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end,
                    function(____, reason)
                        reject(nil, reason)
                    end
                )
            end
        end
    )
end

local function __TS__PromiseAllSettled(iterable)
    local results = {}
    local toResolve = {}
    local numToResolve = 0
    local i = 0
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                results[i + 1] = {status = "fulfilled", value = item.value}
            elseif item.state == 2 then
                results[i + 1] = {status = "rejected", reason = item.rejectionReason}
            else
                numToResolve = numToResolve + 1
                toResolve[i] = item
            end
        else
            results[i + 1] = {status = "fulfilled", value = item}
        end
        i = i + 1
    end
    if numToResolve == 0 then
        return __TS__Promise.resolve(results)
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve)
            for index, promise in pairs(toResolve) do
                promise["then"](
                    promise,
                    function(____, data)
                        results[index + 1] = {status = "fulfilled", value = data}
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end,
                    function(____, reason)
                        results[index + 1] = {status = "rejected", reason = reason}
                        numToResolve = numToResolve - 1
                        if numToResolve == 0 then
                            resolve(nil, results)
                        end
                    end
                )
            end
        end
    )
end

local function __TS__PromiseAny(iterable)
    local rejections = {}
    local pending = {}
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                return __TS__Promise.resolve(item.value)
            elseif item.state == 2 then
                rejections[#rejections + 1] = item.rejectionReason
            else
                pending[#pending + 1] = item
            end
        else
            return __TS__Promise.resolve(item)
        end
    end
    if #pending == 0 then
        return __TS__Promise.reject("No promises to resolve with .any()")
    end
    local numResolved = 0
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for ____, promise in ipairs(pending) do
                promise["then"](
                    promise,
                    function(____, data)
                        resolve(nil, data)
                    end,
                    function(____, reason)
                        rejections[#rejections + 1] = reason
                        numResolved = numResolved + 1
                        if numResolved == #pending then
                            reject(nil, {name = "AggregateError", message = "All Promises rejected", errors = rejections})
                        end
                    end
                )
            end
        end
    )
end

local function __TS__PromiseRace(iterable)
    local pending = {}
    for ____, item in __TS__Iterator(iterable) do
        if __TS__InstanceOf(item, __TS__Promise) then
            if item.state == 1 then
                return __TS__Promise.resolve(item.value)
            elseif item.state == 2 then
                return __TS__Promise.reject(item.rejectionReason)
            else
                pending[#pending + 1] = item
            end
        else
            return __TS__Promise.resolve(item)
        end
    end
    return __TS__New(
        __TS__Promise,
        function(____, resolve, reject)
            for ____, promise in ipairs(pending) do
                promise["then"](
                    promise,
                    function(____, value) return resolve(nil, value) end,
                    function(____, reason) return reject(nil, reason) end
                )
            end
        end
    )
end

local Set
do
    Set = __TS__Class()
    Set.name = "Set"
    function Set.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "Set"
        self.size = 0
        self.nextKey = {}
        self.previousKey = {}
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self:add(result.value)
            end
        else
            local array = values
            for ____, value in ipairs(array) do
                self:add(value)
            end
        end
    end
    function Set.prototype.add(self, value)
        local isNewValue = not self:has(value)
        if isNewValue then
            self.size = self.size + 1
        end
        if self.firstKey == nil then
            self.firstKey = value
            self.lastKey = value
        elseif isNewValue then
            self.nextKey[self.lastKey] = value
            self.previousKey[value] = self.lastKey
            self.lastKey = value
        end
        return self
    end
    function Set.prototype.clear(self)
        self.nextKey = {}
        self.previousKey = {}
        self.firstKey = nil
        self.lastKey = nil
        self.size = 0
    end
    function Set.prototype.delete(self, value)
        local contains = self:has(value)
        if contains then
            self.size = self.size - 1
            local next = self.nextKey[value]
            local previous = self.previousKey[value]
            if next ~= nil and previous ~= nil then
                self.nextKey[previous] = next
                self.previousKey[next] = previous
            elseif next ~= nil then
                self.firstKey = next
                self.previousKey[next] = nil
            elseif previous ~= nil then
                self.lastKey = previous
                self.nextKey[previous] = nil
            else
                self.firstKey = nil
                self.lastKey = nil
            end
            self.nextKey[value] = nil
            self.previousKey[value] = nil
        end
        return contains
    end
    function Set.prototype.forEach(self, callback)
        for ____, key in __TS__Iterator(self:keys()) do
            callback(nil, key, key, self)
        end
    end
    function Set.prototype.has(self, value)
        return self.nextKey[value] ~= nil or self.lastKey == value
    end
    Set.prototype[Symbol.iterator] = function(self)
        return self:values()
    end
    function Set.prototype.entries(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = {key, key}}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.keys(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.values(self)
        local nextKey = self.nextKey
        local key = self.firstKey
        return {
            [Symbol.iterator] = function(self)
                return self
            end,
            next = function(self)
                local result = {done = not key, value = key}
                key = nextKey[key]
                return result
            end
        }
    end
    function Set.prototype.union(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            result:add(item)
        end
        return result
    end
    function Set.prototype.intersection(self, other)
        local result = __TS__New(Set)
        for ____, item in __TS__Iterator(self) do
            if other:has(item) then
                result:add(item)
            end
        end
        return result
    end
    function Set.prototype.difference(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            result:delete(item)
        end
        return result
    end
    function Set.prototype.symmetricDifference(self, other)
        local result = __TS__New(Set, self)
        for ____, item in __TS__Iterator(other) do
            if self:has(item) then
                result:delete(item)
            else
                result:add(item)
            end
        end
        return result
    end
    function Set.prototype.isSubsetOf(self, other)
        for ____, item in __TS__Iterator(self) do
            if not other:has(item) then
                return false
            end
        end
        return true
    end
    function Set.prototype.isSupersetOf(self, other)
        for ____, item in __TS__Iterator(other) do
            if not self:has(item) then
                return false
            end
        end
        return true
    end
    function Set.prototype.isDisjointFrom(self, other)
        for ____, item in __TS__Iterator(self) do
            if other:has(item) then
                return false
            end
        end
        return true
    end
    Set[Symbol.species] = Set
end

local function __TS__SparseArrayNew(...)
    local sparseArray = {...}
    sparseArray.sparseLength = __TS__CountVarargs(...)
    return sparseArray
end

local function __TS__SparseArrayPush(sparseArray, ...)
    local args = {...}
    local argsLen = __TS__CountVarargs(...)
    local listLen = sparseArray.sparseLength
    for i = 1, argsLen do
        sparseArray[listLen + i] = args[i]
    end
    sparseArray.sparseLength = listLen + argsLen
end

local function __TS__SparseArraySpread(sparseArray)
    local _unpack = unpack or table.unpack
    return _unpack(sparseArray, 1, sparseArray.sparseLength)
end

local WeakMap
do
    WeakMap = __TS__Class()
    WeakMap.name = "WeakMap"
    function WeakMap.prototype.____constructor(self, entries)
        self[Symbol.toStringTag] = "WeakMap"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if entries == nil then
            return
        end
        local iterable = entries
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                local value = result.value
                self.items[value[1]] = value[2]
            end
        else
            for ____, kvp in ipairs(entries) do
                self.items[kvp[1]] = kvp[2]
            end
        end
    end
    function WeakMap.prototype.delete(self, key)
        local contains = self:has(key)
        self.items[key] = nil
        return contains
    end
    function WeakMap.prototype.get(self, key)
        return self.items[key]
    end
    function WeakMap.prototype.has(self, key)
        return self.items[key] ~= nil
    end
    function WeakMap.prototype.set(self, key, value)
        self.items[key] = value
        return self
    end
    WeakMap[Symbol.species] = WeakMap
end

local WeakSet
do
    WeakSet = __TS__Class()
    WeakSet.name = "WeakSet"
    function WeakSet.prototype.____constructor(self, values)
        self[Symbol.toStringTag] = "WeakSet"
        self.items = {}
        setmetatable(self.items, {__mode = "k"})
        if values == nil then
            return
        end
        local iterable = values
        if iterable[Symbol.iterator] then
            local iterator = iterable[Symbol.iterator](iterable)
            while true do
                local result = iterator:next()
                if result.done then
                    break
                end
                self.items[result.value] = true
            end
        else
            for ____, value in ipairs(values) do
                self.items[value] = true
            end
        end
    end
    function WeakSet.prototype.add(self, value)
        self.items[value] = true
        return self
    end
    function WeakSet.prototype.delete(self, value)
        local contains = self:has(value)
        self.items[value] = nil
        return contains
    end
    function WeakSet.prototype.has(self, value)
        return self.items[value] == true
    end
    WeakSet[Symbol.species] = WeakSet
end

local function __TS__SourceMapTraceBack(fileName, sourceMap)
    _G.__TS__sourcemap = _G.__TS__sourcemap or ({})
    _G.__TS__sourcemap[fileName] = sourceMap
    if _G.__TS__originalTraceback == nil then
        local originalTraceback = debug.traceback
        _G.__TS__originalTraceback = originalTraceback
        debug.traceback = function(thread, message, level)
            local trace
            if thread == nil and message == nil and level == nil then
                trace = originalTraceback()
            elseif __TS__StringIncludes(_VERSION, "Lua 5.0") then
                trace = originalTraceback((("[Level " .. tostring(level)) .. "] ") .. tostring(message))
            else
                trace = originalTraceback(thread, message, level)
            end
            if type(trace) ~= "string" then
                return trace
            end
            local function replacer(____, file, srcFile, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (srcFile .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            local result = string.gsub(
                trace,
                "(%S+)%.lua:(%d+)",
                function(file, line) return replacer(nil, file .. ".lua", file .. ".ts", line) end
            )
            local function stringReplacer(____, file, line)
                local fileSourceMap = _G.__TS__sourcemap[file]
                if fileSourceMap ~= nil and fileSourceMap[line] ~= nil then
                    local chunkName = (__TS__Match(file, "%[string \"([^\"]+)\"%]"))
                    local sourceName = string.gsub(chunkName, ".lua$", ".ts")
                    local data = fileSourceMap[line]
                    if type(data) == "number" then
                        return (sourceName .. ":") .. tostring(data)
                    end
                    return (data.file .. ":") .. tostring(data.line)
                end
                return (file .. ":") .. line
            end
            result = string.gsub(
                result,
                "(%[string \"[^\"]+\"%]):(%d+)",
                function(file, line) return stringReplacer(nil, file, line) end
            )
            return result
        end
    end
end

local function __TS__Spread(iterable)
    local arr = {}
    if type(iterable) == "string" then
        for i = 0, #iterable - 1 do
            arr[i + 1] = __TS__StringAccess(iterable, i)
        end
    else
        local len = 0
        for ____, item in __TS__Iterator(iterable) do
            len = len + 1
            arr[len] = item
        end
    end
    return __TS__Unpack(arr)
end

local function __TS__StringCharAt(self, pos)
    if pos ~= pos then
        pos = 0
    end
    if pos < 0 then
        return ""
    end
    return string.sub(self, pos + 1, pos + 1)
end

local function __TS__StringCharCodeAt(self, index)
    if index ~= index then
        index = 0
    end
    if index < 0 then
        return 0 / 0
    end
    return string.byte(self, index + 1) or 0 / 0
end

local function __TS__StringEndsWith(self, searchString, endPosition)
    if endPosition == nil or endPosition > #self then
        endPosition = #self
    end
    return string.sub(self, endPosition - #searchString + 1, endPosition) == searchString
end

local function __TS__StringPadEnd(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if maxLength == -math.huge or maxLength == math.huge then
        error("Invalid string length", 0)
    end
    if #self >= maxLength or #fillString == 0 then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = fillString .. string.rep(
            fillString,
            math.floor(maxLength / #fillString)
        )
    end
    return self .. string.sub(
        fillString,
        1,
        math.floor(maxLength)
    )
end

local function __TS__StringPadStart(self, maxLength, fillString)
    if fillString == nil then
        fillString = " "
    end
    if maxLength ~= maxLength then
        maxLength = 0
    end
    if maxLength == -math.huge or maxLength == math.huge then
        error("Invalid string length", 0)
    end
    if #self >= maxLength or #fillString == 0 then
        return self
    end
    maxLength = maxLength - #self
    if maxLength > #fillString then
        fillString = fillString .. string.rep(
            fillString,
            math.floor(maxLength / #fillString)
        )
    end
    return string.sub(
        fillString,
        1,
        math.floor(maxLength)
    ) .. self
end

local __TS__StringReplace
do
    local sub = string.sub
    function __TS__StringReplace(source, searchValue, replaceValue)
        local startPos, endPos = string.find(source, searchValue, nil, true)
        if not startPos then
            return source
        end
        local before = sub(source, 1, startPos - 1)
        local replacement = type(replaceValue) == "string" and replaceValue or replaceValue(nil, searchValue, startPos - 1, source)
        local after = sub(source, endPos + 1)
        return (before .. replacement) .. after
    end
end

local __TS__StringSplit
do
    local sub = string.sub
    local find = string.find
    function __TS__StringSplit(source, separator, limit)
        if limit == nil then
            limit = 4294967295
        end
        if limit == 0 then
            return {}
        end
        local result = {}
        local resultIndex = 1
        if separator == nil or separator == "" then
            for i = 1, #source do
                result[resultIndex] = sub(source, i, i)
                resultIndex = resultIndex + 1
            end
        else
            local currentPos = 1
            while resultIndex <= limit do
                local startPos, endPos = find(source, separator, currentPos, true)
                if not startPos then
                    break
                end
                result[resultIndex] = sub(source, currentPos, startPos - 1)
                resultIndex = resultIndex + 1
                currentPos = endPos + 1
            end
            if resultIndex <= limit then
                result[resultIndex] = sub(source, currentPos)
            end
        end
        return result
    end
end

local __TS__StringReplaceAll
do
    local sub = string.sub
    local find = string.find
    function __TS__StringReplaceAll(source, searchValue, replaceValue)
        if type(replaceValue) == "string" then
            local concat = table.concat(
                __TS__StringSplit(source, searchValue),
                replaceValue
            )
            if #searchValue == 0 then
                return (replaceValue .. concat) .. replaceValue
            end
            return concat
        end
        local parts = {}
        local partsIndex = 1
        if #searchValue == 0 then
            parts[1] = replaceValue(nil, "", 0, source)
            partsIndex = 2
            for i = 1, #source do
                parts[partsIndex] = sub(source, i, i)
                parts[partsIndex + 1] = replaceValue(nil, "", i, source)
                partsIndex = partsIndex + 2
            end
        else
            local currentPos = 1
            while true do
                local startPos, endPos = find(source, searchValue, currentPos, true)
                if not startPos then
                    break
                end
                parts[partsIndex] = sub(source, currentPos, startPos - 1)
                parts[partsIndex + 1] = replaceValue(nil, searchValue, startPos - 1, source)
                partsIndex = partsIndex + 2
                currentPos = endPos + 1
            end
            parts[partsIndex] = sub(source, currentPos)
        end
        return table.concat(parts)
    end
end

local function __TS__StringSlice(self, start, ____end)
    if start == nil or start ~= start then
        start = 0
    end
    if ____end ~= ____end then
        ____end = 0
    end
    if start >= 0 then
        start = start + 1
    end
    if ____end ~= nil and ____end < 0 then
        ____end = ____end - 1
    end
    return string.sub(self, start, ____end)
end

local function __TS__StringStartsWith(self, searchString, position)
    if position == nil or position < 0 then
        position = 0
    end
    return string.sub(self, position + 1, #searchString + position) == searchString
end

local function __TS__StringSubstr(self, from, length)
    if from ~= from then
        from = 0
    end
    if length ~= nil then
        if length ~= length or length <= 0 then
            return ""
        end
        length = length + from
    end
    if from >= 0 then
        from = from + 1
    end
    return string.sub(self, from, length)
end

local function __TS__StringTrim(self)
    local result = string.gsub(self, "^[%s ﻿]*(.-)[%s ﻿]*$", "%1")
    return result
end

local function __TS__StringTrimEnd(self)
    local result = string.gsub(self, "[%s ﻿]*$", "")
    return result
end

local function __TS__StringTrimStart(self)
    local result = string.gsub(self, "^[%s ﻿]*", "")
    return result
end

local __TS__SymbolRegistryFor, __TS__SymbolRegistryKeyFor
do
    local symbolRegistry = {}
    function __TS__SymbolRegistryFor(key)
        if not symbolRegistry[key] then
            symbolRegistry[key] = __TS__Symbol(key)
        end
        return symbolRegistry[key]
    end
    function __TS__SymbolRegistryKeyFor(sym)
        for key in pairs(symbolRegistry) do
            if symbolRegistry[key] == sym then
                return key
            end
        end
        return nil
    end
end

local function __TS__TypeOf(value)
    local luaType = type(value)
    if luaType == "table" then
        return "object"
    elseif luaType == "nil" then
        return "undefined"
    else
        return luaType
    end
end

local function __TS__Using(self, cb, ...)
    local args = {...}
    local thrownError
    local ok, result = xpcall(
        function() return cb(
            nil,
            __TS__Unpack(args)
        ) end,
        function(err)
            thrownError = err
            return thrownError
        end
    )
    local argArray = {__TS__Unpack(args)}
    do
        local i = #argArray - 1
        while i >= 0 do
            local ____self_0 = argArray[i + 1]
            ____self_0[Symbol.dispose](____self_0)
            i = i - 1
        end
    end
    if not ok then
        error(thrownError, 0)
    end
    return result
end

local function __TS__UsingAsync(self, cb, ...)
    local args = {...}
    return __TS__AsyncAwaiter(function(____awaiter_resolve)
        local thrownError
        local ok, result = xpcall(
            function() return cb(
                nil,
                __TS__Unpack(args)
            ) end,
            function(err)
                thrownError = err
                return thrownError
            end
        )
        local argArray = {__TS__Unpack(args)}
        do
            local i = #argArray - 1
            while i >= 0 do
                if argArray[i + 1][Symbol.dispose] ~= nil then
                    local ____self_0 = argArray[i + 1]
                    ____self_0[Symbol.dispose](____self_0)
                end
                if argArray[i + 1][Symbol.asyncDispose] ~= nil then
                    local ____self_1 = argArray[i + 1]
                    __TS__Await(____self_1[Symbol.asyncDispose](____self_1))
                end
                i = i - 1
            end
        end
        if not ok then
            error(thrownError, 0)
        end
        return ____awaiter_resolve(nil, result)
    end)
end

return {
  __TS__ArrayAt = __TS__ArrayAt,
  __TS__ArrayConcat = __TS__ArrayConcat,
  __TS__ArrayEntries = __TS__ArrayEntries,
  __TS__ArrayEvery = __TS__ArrayEvery,
  __TS__ArrayFill = __TS__ArrayFill,
  __TS__ArrayFilter = __TS__ArrayFilter,
  __TS__ArrayForEach = __TS__ArrayForEach,
  __TS__ArrayFind = __TS__ArrayFind,
  __TS__ArrayFindIndex = __TS__ArrayFindIndex,
  __TS__ArrayFrom = __TS__ArrayFrom,
  __TS__ArrayIncludes = __TS__ArrayIncludes,
  __TS__ArrayIndexOf = __TS__ArrayIndexOf,
  __TS__ArrayIsArray = __TS__ArrayIsArray,
  __TS__ArrayJoin = __TS__ArrayJoin,
  __TS__ArrayMap = __TS__ArrayMap,
  __TS__ArrayPush = __TS__ArrayPush,
  __TS__ArrayPushArray = __TS__ArrayPushArray,
  __TS__ArrayReduce = __TS__ArrayReduce,
  __TS__ArrayReduceRight = __TS__ArrayReduceRight,
  __TS__ArrayReverse = __TS__ArrayReverse,
  __TS__ArrayUnshift = __TS__ArrayUnshift,
  __TS__ArraySort = __TS__ArraySort,
  __TS__ArraySlice = __TS__ArraySlice,
  __TS__ArraySome = __TS__ArraySome,
  __TS__ArraySplice = __TS__ArraySplice,
  __TS__ArrayToObject = __TS__ArrayToObject,
  __TS__ArrayFlat = __TS__ArrayFlat,
  __TS__ArrayFlatMap = __TS__ArrayFlatMap,
  __TS__ArraySetLength = __TS__ArraySetLength,
  __TS__ArrayToReversed = __TS__ArrayToReversed,
  __TS__ArrayToSorted = __TS__ArrayToSorted,
  __TS__ArrayToSpliced = __TS__ArrayToSpliced,
  __TS__ArrayWith = __TS__ArrayWith,
  __TS__AsyncAwaiter = __TS__AsyncAwaiter,
  __TS__Await = __TS__Await,
  __TS__Class = __TS__Class,
  __TS__ClassExtends = __TS__ClassExtends,
  __TS__CloneDescriptor = __TS__CloneDescriptor,
  __TS__CountVarargs = __TS__CountVarargs,
  __TS__Decorate = __TS__Decorate,
  __TS__DecorateLegacy = __TS__DecorateLegacy,
  __TS__DecorateParam = __TS__DecorateParam,
  __TS__Delete = __TS__Delete,
  __TS__DelegatedYield = __TS__DelegatedYield,
  __TS__DescriptorGet = __TS__DescriptorGet,
  __TS__DescriptorSet = __TS__DescriptorSet,
  Error = Error,
  RangeError = RangeError,
  ReferenceError = ReferenceError,
  SyntaxError = SyntaxError,
  TypeError = TypeError,
  URIError = URIError,
  __TS__FunctionBind = __TS__FunctionBind,
  __TS__Generator = __TS__Generator,
  __TS__InstanceOf = __TS__InstanceOf,
  __TS__InstanceOfObject = __TS__InstanceOfObject,
  __TS__Iterator = __TS__Iterator,
  __TS__LuaIteratorSpread = __TS__LuaIteratorSpread,
  Map = Map,
  __TS__MapGroupBy = __TS__MapGroupBy,
  __TS__Match = __TS__Match,
  __TS__MathAtan2 = __TS__MathAtan2,
  __TS__MathModf = __TS__MathModf,
  __TS__MathSign = __TS__MathSign,
  __TS__MathTrunc = __TS__MathTrunc,
  __TS__New = __TS__New,
  __TS__Number = __TS__Number,
  __TS__NumberIsFinite = __TS__NumberIsFinite,
  __TS__NumberIsInteger = __TS__NumberIsInteger,
  __TS__NumberIsNaN = __TS__NumberIsNaN,
  __TS__ParseInt = __TS__ParseInt,
  __TS__ParseFloat = __TS__ParseFloat,
  __TS__NumberToString = __TS__NumberToString,
  __TS__NumberToFixed = __TS__NumberToFixed,
  __TS__ObjectAssign = __TS__ObjectAssign,
  __TS__ObjectDefineProperty = __TS__ObjectDefineProperty,
  __TS__ObjectEntries = __TS__ObjectEntries,
  __TS__ObjectFromEntries = __TS__ObjectFromEntries,
  __TS__ObjectGetOwnPropertyDescriptor = __TS__ObjectGetOwnPropertyDescriptor,
  __TS__ObjectGetOwnPropertyDescriptors = __TS__ObjectGetOwnPropertyDescriptors,
  __TS__ObjectGroupBy = __TS__ObjectGroupBy,
  __TS__ObjectKeys = __TS__ObjectKeys,
  __TS__ObjectRest = __TS__ObjectRest,
  __TS__ObjectValues = __TS__ObjectValues,
  __TS__ParseFloat = __TS__ParseFloat,
  __TS__ParseInt = __TS__ParseInt,
  __TS__Promise = __TS__Promise,
  __TS__PromiseAll = __TS__PromiseAll,
  __TS__PromiseAllSettled = __TS__PromiseAllSettled,
  __TS__PromiseAny = __TS__PromiseAny,
  __TS__PromiseRace = __TS__PromiseRace,
  Set = Set,
  __TS__SetDescriptor = __TS__SetDescriptor,
  __TS__SparseArrayNew = __TS__SparseArrayNew,
  __TS__SparseArrayPush = __TS__SparseArrayPush,
  __TS__SparseArraySpread = __TS__SparseArraySpread,
  WeakMap = WeakMap,
  WeakSet = WeakSet,
  __TS__SourceMapTraceBack = __TS__SourceMapTraceBack,
  __TS__Spread = __TS__Spread,
  __TS__StringAccess = __TS__StringAccess,
  __TS__StringCharAt = __TS__StringCharAt,
  __TS__StringCharCodeAt = __TS__StringCharCodeAt,
  __TS__StringEndsWith = __TS__StringEndsWith,
  __TS__StringIncludes = __TS__StringIncludes,
  __TS__StringPadEnd = __TS__StringPadEnd,
  __TS__StringPadStart = __TS__StringPadStart,
  __TS__StringReplace = __TS__StringReplace,
  __TS__StringReplaceAll = __TS__StringReplaceAll,
  __TS__StringSlice = __TS__StringSlice,
  __TS__StringSplit = __TS__StringSplit,
  __TS__StringStartsWith = __TS__StringStartsWith,
  __TS__StringSubstr = __TS__StringSubstr,
  __TS__StringSubstring = __TS__StringSubstring,
  __TS__StringTrim = __TS__StringTrim,
  __TS__StringTrimEnd = __TS__StringTrimEnd,
  __TS__StringTrimStart = __TS__StringTrimStart,
  __TS__Symbol = __TS__Symbol,
  Symbol = Symbol,
  __TS__SymbolRegistryFor = __TS__SymbolRegistryFor,
  __TS__SymbolRegistryKeyFor = __TS__SymbolRegistryKeyFor,
  __TS__TypeOf = __TS__TypeOf,
  __TS__Unpack = __TS__Unpack,
  __TS__Using = __TS__Using,
  __TS__UsingAsync = __TS__UsingAsync
}
 end,
["lua.helpers.module.useModule"] = function(...) 
local ____exports = {}
function ____exports.useExternalModule(importTarget)
    do
        local function ____catch()
            console.error("Failed to import module " .. importTarget)
            return true, nil
        end
        local ____try, ____hasReturned, ____returnValue = pcall(function()
            return true, require(importTarget)
        end)
        if not ____try then
            ____hasReturned, ____returnValue = ____catch()
        end
        if ____hasReturned then
            return ____returnValue
        end
    end
end
return ____exports
 end,
["lua.plugins.nui"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
____exports.useNUI = function()
    return {
        Popup = useExternalModule("nui.popup"),
        Layout = useExternalModule("nui.layout"),
        Input = useExternalModule("nui.input"),
        Menu = useExternalModule("nui.menu"),
        Table = useExternalModule("nui.table"),
        Tree = useExternalModule("nui.tree"),
        event = useExternalModule("nui.utils.autocmd")
    }
end
local plugin = {[1] = "MunifTanjim/nui.nvim"}
____exports.default = plugin
return ____exports
 end,
["lua.custom.custom-open.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__StringReplaceAll = ____lualib.__TS__StringReplaceAll
local ____exports = {}
local ____nui = require("lua.plugins.nui")
local useNUI = ____nui.useNUI
local VIM_OPEN = vim.ui.open
local function open(target)
    local targets = __TS__ArrayFilter(
        {{pattern = ".*", name = "Firefox", command = "firefox %OPEN_TARGET%"}},
        function(____, pmatch)
            local result = vim.regex(pmatch.pattern):match_str(target)
            return result
        end
    )
    if #targets < 1 then
        return VIM_OPEN(target)
    end
    local NUI = useNUI()
    local menu = NUI.Menu(
        {position = "50%", size = {width = 33, height = 5}, border = {style = "single", text = {top = "Select Handler Program"}}},
        {
            lines = __TS__ArrayMap(
                targets,
                function(____, target) return NUI.Menu.item(target.name, {target = target}) end
            ),
            on_submit = function(_item)
                local item = _item
                local command = __TS__StringReplaceAll(item.target.command, "%OPEN_TARGET%", target)
                os.execute(command)
            end
        }
    )
    menu:mount()
    return nil
end
function ____exports.initCustomOpen()
    vim.ui.open = open
end
return ____exports
 end,
["lua.helpers.env-parser.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__ArraySlice = ____lualib.__TS__ArraySlice
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__StringReplaceAll = ____lualib.__TS__StringReplaceAll
local __TS__StringSlice = ____lualib.__TS__StringSlice
local ____exports = {}
function ____exports.parseEnvFileContent(content)
    local result = {}
    local lines = __TS__ArrayFilter(
        __TS__ArrayFilter(
            __TS__ArrayMap(
                __TS__StringSplit(content, "\n"),
                function(____, x) return __TS__StringTrim(x) end
            ),
            function(____, x) return #x > 0 end
        ),
        function(____, x) return not __TS__StringStartsWith(x, "#") end
    )
    for ____, line in ipairs(lines) do
        local ____TS__StringSplit_result_0 = __TS__StringSplit(line, "=")
        local key = ____TS__StringSplit_result_0[1]
        local valuePossibleSplit = __TS__ArraySlice(____TS__StringSplit_result_0, 1)
        local valueWithPossibleComment = table.concat(valuePossibleSplit, "=")
        local value, comment = unpack(__TS__ArrayMap(
            __TS__StringSplit(valueWithPossibleComment, "#"),
            function(____, x) return __TS__StringTrim(x) end
        ))
        local STRING_DELIMS = {"\"", "'"}
        local delimiter = __TS__ArrayFind(
            STRING_DELIMS,
            function(____, x) return __TS__StringStartsWith(value, x) end
        )
        local finalValue = value
        if delimiter ~= nil then
            finalValue = __TS__StringReplaceAll(finalValue, "\\" .. delimiter, delimiter)
            finalValue = __TS__StringSlice(finalValue, 1, #finalValue - 1)
            finalValue = __TS__StringReplaceAll(finalValue, "\\n", "\n")
        end
        result[key] = finalValue
    end
    return result
end
return ____exports
 end,
["lua.helpers.user_command.argparser"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringStartsWith = ____lualib.__TS__StringStartsWith
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__StringAccess = ____lualib.__TS__StringAccess
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local __TS__StringSlice = ____lualib.__TS__StringSlice
local ____exports = {}
function ____exports.parseArgs(args)
    local result = {}
    local primedKey = nil
    do
        local i = 0
        while i < #args do
            local segment = args[i + 1]
            if __TS__StringStartsWith(segment, "--") then
                if primedKey ~= nil then
                    result[primedKey] = true
                end
                primedKey = string.sub(segment, 3)
            else
                if primedKey == nil then
                    error(
                        __TS__New(Error, "Expected a key, got a value"),
                        0
                    )
                elseif __TS__StringStartsWith(segment, "\"") or __TS__StringStartsWith(segment, "'") then
                    local delim = __TS__StringAccess(segment, 0)
                    local valueResult = string.sub(segment, 2)
                    local ____end = i
                    while ____end < #args and not __TS__StringEndsWith(args[____end + 1], delim) do
                        ____end = ____end + 1
                        valueResult = valueResult .. " " .. args[____end + 1]
                    end
                    if ____end >= #args or not __TS__StringEndsWith(args[____end + 1], delim) then
                        error(
                            __TS__New(Error, "Unterminated string: " .. args[____end + 1]),
                            0
                        )
                    end
                    valueResult = __TS__StringSlice(valueResult, 0, #valueResult - 1)
                    result[primedKey] = valueResult
                    i = ____end
                else
                    result[primedKey] = segment
                end
                primedKey = nil
            end
            i = i + 1
        end
    end
    if primedKey ~= nil then
        result[primedKey] = true
    end
    return result
end
return ____exports
 end,
["lua.shims.fs.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local function readFileSync(target)
    local file = io.open(target, "r")
    if file == nil then
        error(
            __TS__New(Error, "Failed to open file for read"),
            0
        )
    end
    local content = file:read("*a")
    file:close()
    if content == nil then
        error(
            __TS__New(Error, "Failed to read file"),
            0
        )
    end
    return content
end
local function writeFileSync(path, content)
    local file = io.open(path, "w")
    if file == nil then
        error(
            __TS__New(Error, "Failed to open file for writing"),
            0
        )
    end
    file:write(content)
    file:close()
end
local function readdirSync(path)
    local files = {}
    local handle = vim.uv.fs_scandir(path)
    if handle == nil then
        error(
            __TS__New(Error, "Cannot open directory " .. path),
            0
        )
    end
    while true do
        local name, ____type = vim.uv.fs_scandir_next(handle)
        if name == nil then
            break
        end
        files[#files + 1] = {path = name, type = ____type}
    end
    return files
end
local function existsSync(target)
    local file = io.open(target, "r")
    if file ~= nil then
        file:close()
        return true
    else
        return false
    end
end
____exports.fs = {readFileSync = readFileSync, existsSync = existsSync, writeFileSync = writeFileSync, readdirSync = readdirSync}
return ____exports
 end,
["lua.custom.env-load.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringEndsWith = ____lualib.__TS__StringEndsWith
local __TS__StringReplace = ____lualib.__TS__StringReplace
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local ____exports = {}
local ____env_2Dparser = require("lua.helpers.env-parser.index")
local parseEnvFileContent = ____env_2Dparser.parseEnvFileContent
local ____argparser = require("lua.helpers.user_command.argparser")
local parseArgs = ____argparser.parseArgs
local ____fs = require("lua.shims.fs.index")
local fs = ____fs.fs
local function loadEnvFromFile(targetFile, overwrite)
    local fileContent = fs.readFileSync(targetFile)
    local variables = parseEnvFileContent(fileContent)
    for key in pairs(variables) do
        do
            if vim.env[key] ~= nil then
                if not overwrite then
                    vim.notify(("Skipping environment variable '" .. key) .. "' because it's already set, and '--overwrite' was not specified", vim.log.levels.WARN)
                    goto __continue3
                end
            end
            vim.env[key] = variables[key]
        end
        ::__continue3::
    end
end
local _locatedEnvFiles = nil
vim.api.nvim_create_autocmd(
    "DirChanged",
    {callback = function()
        _locatedEnvFiles = nil
    end}
)
local function locateEnvFiles()
    if _locatedEnvFiles ~= nil then
        return _locatedEnvFiles
    end
    local cwd = vim.fn.getcwd()
    local envFiles = {}
    local crawl
    crawl = function(path)
        local entries = fs.readdirSync(path)
        for ____, entry in ipairs(entries) do
            do
                if entry.type == "file" then
                    if __TS__StringEndsWith(entry.path, ".env") then
                        envFiles[#envFiles + 1] = (path .. "/") .. entry.path
                    end
                elseif entry.type == "directory" then
                    if entry.path == ".." then
                        goto __continue11
                    end
                    if entry.path == "." then
                        goto __continue11
                    end
                    do
                        local function ____catch()
                            if vim.g.debug_env_load then
                                vim.notify(((("Failed to crawl directory '" .. path) .. "/") .. entry.path) .. "'")
                            end
                        end
                        local ____try = pcall(function()
                            crawl((path .. "/") .. entry.path)
                        end)
                        if not ____try then
                            ____catch()
                        end
                    end
                end
            end
            ::__continue11::
        end
    end
    crawl(cwd)
    _locatedEnvFiles = envFiles
    return envFiles
end
local function showEnvSourceDialog()
    local files = locateEnvFiles()
    vim.ui.select(
        files,
        {
            prompt = "Select a file to load",
            format_item = function(item)
                return __TS__StringReplace(
                    item,
                    vim.fn.getcwd() .. "/",
                    ""
                )
            end
        },
        function(choice)
            if choice == nil then
                return
            end
            vim.ui.select(
                {false, true},
                {
                    prompt = __TS__StringReplace(
                        choice,
                        vim.fn.getcwd() .. "/",
                        ""
                    ) .. ": Override Duplicates?",
                    format_item = function(item)
                        return item and "Yes" or "No"
                    end
                },
                function(override)
                    if override == nil then
                        return
                    end
                    loadEnvFromFile(choice, override)
                end
            )
        end
    )
end
function ____exports.initCustomEnvLoader()
    vim.api.nvim_create_user_command(
        "Env",
        function(_args)
            local args = parseArgs(_args.fargs)
            if #__TS__ObjectKeys(args) < 1 then
                vim.notify("Use --from-file, --scan, or --pick")
                return
            end
            local resolved = false
            if args["from-file"] ~= nil then
                resolved = true
                loadEnvFromFile(args["from-file"], not not args.overwrite)
            end
            if args.scan ~= nil then
                resolved = true
                local files = locateEnvFiles()
                for ____, file in ipairs(files) do
                    vim.notify(file)
                end
            end
            if args.pick ~= nil then
                resolved = true
                showEnvSourceDialog()
            end
            if not resolved then
                vim.notify(
                    "Cannot handle keys " .. table.concat(
                        __TS__ObjectKeys(args),
                        ","
                    ),
                    vim.log.levels.ERROR
                )
            end
        end,
        {nargs = "*"}
    )
end
return ____exports
 end,
["lua.helpers.keymap.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
function ____exports.keyMappingExists(mode, bind)
    local result = vim.api.nvim_call_function("mapcheck", {bind, mode})
    if result ~= nil and #result > 0 then
        return true
    else
        return false
    end
end
function ____exports.applyKeyMapping(map)
    map.options = __TS__ObjectAssign({silent = true}, map.options)
    if map.action ~= nil then
        vim.keymap.set(map.mode, map.inputStroke, map.action, map.options)
    else
        vim.keymap.set(map.mode, map.inputStroke, map.outputStroke, map.options)
    end
end
return ____exports
 end,
["lua.custom.git.index"] = function(...) 
local ____exports = {}
local ____keymap = require("lua.helpers.keymap.index")
local applyKeyMapping = ____keymap.applyKeyMapping
function ____exports.initCustomGit()
    applyKeyMapping({
        mode = "n",
        inputStroke = "<c-c>",
        action = function()
            vim.ui.input(
                {prompt = "Commit Message: "},
                function(message)
                    if message == nil or #message < 1 then
                        return
                    else
                        vim.notify(vim.fn.system({"git", "add", "--all"}))
                        vim.notify(vim.fn.system({"git", "commit", "-m", message}))
                    end
                end
            )
        end,
        options = {desc = "Commit"}
    })
end
return ____exports
 end,
["lua.custom.jumplist.index"] = function(...) 
local ____exports = {}
function ____exports.initCustomJumplist()
    vim.api.nvim_create_user_command(
        "JumpListClear",
        function()
            vim.cmd("tabdo windo clearjumps | tabnext")
        end,
        {}
    )
end
return ____exports
 end,
["lua.custom.profile.index"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____argparser = require("lua.helpers.user_command.argparser")
local parseArgs = ____argparser.parseArgs
function ____exports.setupCustomProfilerCommands()
    vim.api.nvim_create_user_command(
        "LuaJITProfiler",
        function(_args)
            local args = parseArgs(_args.fargs)
            local function getJIT()
                return useExternalModule("jit.p")
            end
            if args.operation == "start" then
                getJIT().start("32", "profile.txt")
            elseif args.operation == "stop" then
                getJIT().stop()
            end
        end,
        {nargs = "*"}
    )
end
return ____exports
 end,
["lua.custom.nixos.index"] = function(...) 
local ____exports = {}
local ____fs = require("lua.shims.fs.index")
local fs = ____fs.fs
function ____exports.isRunningUnderNixOS()
    return fs.existsSync("/etc/NIXOS")
end
return ____exports
 end,
["lua.theme"] = function(...) 
local ____exports = {}
local h, applySymbolUsageStyle, applyDapSymbols, applyDefaultFoldChars
function h(name)
    return vim.api.nvim_get_hl(0, {name = name})
end
function applySymbolUsageStyle()
    vim.api.nvim_set_hl(
        0,
        "SymbolUsageRounding",
        {
            fg = h("CursorLine").bg,
            italic = true
        }
    )
    vim.api.nvim_set_hl(
        0,
        "SymbolUsageContent",
        {
            bg = h("CursorLine").bg,
            fg = h("Comment").fg,
            italic = true
        }
    )
    vim.api.nvim_set_hl(
        0,
        "SymbolUsageRef",
        {
            fg = h("Function").fg,
            bg = h("CursorLine").bg,
            italic = true
        }
    )
    vim.api.nvim_set_hl(
        0,
        "SymbolUsageDef",
        {
            fg = h("Type").fg,
            bg = h("CursorLine").bg,
            italic = true
        }
    )
    vim.api.nvim_set_hl(
        0,
        "SymbolUsageImpl",
        {
            fg = h("@keyword").fg,
            bg = h("CursorLine").bg,
            italic = true
        }
    )
end
function applyDapSymbols()
    vim.api.nvim_set_hl(0, "DapBreakpoint", {ctermbg = 0, fg = "#993939", bg = "#31353f"})
    vim.api.nvim_set_hl(0, "DapLogPoint", {ctermbg = 0, fg = "#61afef", bg = "#31353f"})
    vim.api.nvim_set_hl(0, "DapStopped", {ctermbg = 0, fg = "#98c379", bg = "#31353f"})
    vim.fn.sign_define("DapBreakpoint", {text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint"})
    vim.fn.sign_define("DapBreakpointCondition", {text = "ﳁ", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint"})
    vim.fn.sign_define("DapBreakpointRejected", {text = "", texthl = "DapBreakpoint", linehl = "DapBreakpoint", numhl = "DapBreakpoint"})
    vim.fn.sign_define("DapLogPoint", {text = "", texthl = "DapLogPoint", linehl = "DapLogPoint", numhl = "DapLogPoint"})
    vim.fn.sign_define("DapStopped", {text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped"})
end
function applyDefaultFoldChars()
    vim.o.fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:"
end
local themeType = "dark"
local callbacks = {}
function ____exports.onThemeChange(callback)
    callbacks[#callbacks + 1] = callback
end
local function updateThemeType(____type)
    themeType = ____type
    for ____, callback in ipairs(callbacks) do
        callback(____type)
    end
end
function ____exports.globalThemeType()
    return themeType
end
local function VSCode()
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated", {bg = "NONE", strikethrough = true, fg = "#808080"})
    applyDefaultFoldChars()
    applyDapSymbols()
    applySymbolUsageStyle()
    updateThemeType("dark")
end
local function TokyoNight()
    vim.cmd("colorscheme tokyonight-storm")
    updateThemeType("dark")
    applyDapSymbols()
    applyDefaultFoldChars()
    applySymbolUsageStyle()
end
local function Catppuccin()
    vim.cmd("colorscheme catppuccin")
    applyDefaultFoldChars()
    applyDapSymbols()
    applySymbolUsageStyle()
    updateThemeType("dark")
end
local function Kanagawa()
    vim.cmd("colorscheme kanagawa")
    updateThemeType("dark")
    applySymbolUsageStyle()
    applyDefaultFoldChars()
    applyDapSymbols()
end
local function Nord()
    vim.cmd("colorscheme nord")
    updateThemeType("dark")
    applySymbolUsageStyle()
    applyDefaultFoldChars()
    applyDapSymbols()
end
____exports.THEME_APPLIERS = {
    VSCode = VSCode,
    TokyoNight = TokyoNight,
    Catppuccin = Catppuccin,
    Kanagawa = Kanagawa,
    Nord = Nord
}
return ____exports
 end,
["lua.helpers.persistent-data.index"] = function(...) 
local ____exports = {}
local ____fs = require("lua.shims.fs.index")
local fs = ____fs.fs
local persistValueInstances = {}
local dataPath = vim.fn.stdpath("data") .. "/winvim"
vim.fn.system({"mkdir", "-p", dataPath})
function ____exports.getWinvimLocalDataDirectory()
    return dataPath
end
function ____exports.usePersistentValue(key, defaultValue)
    do
        local target = persistValueInstances[key]
        if target ~= nil then
            return target
        end
    end
    local filePath = (dataPath .. "/") .. key
    local currentValue = defaultValue
    if fs.existsSync(filePath) then
        currentValue = vim.json.decode(fs.readFileSync(filePath))
    end
    local function get()
        return currentValue
    end
    local function set(newValue)
        currentValue = newValue
        fs.writeFileSync(
            filePath,
            vim.json.encode(newValue)
        )
        return currentValue
    end
    local result = {get, set}
    persistValueInstances[key] = result
    return result
end
return ____exports
 end,
["lua.helpers.configuration.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArrayReverse = ____lualib.__TS__ArrayReverse
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__TypeOf = ____lualib.__TS__TypeOf
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local ____exports = {}
local reloadConfiguration, saveConfiguration, configuration, getGlobalConfig, setGlobalConfig
local ____nixos = require("lua.custom.nixos.index")
local isRunningUnderNixOS = ____nixos.isRunningUnderNixOS
local ____persistent_2Ddata = require("lua.helpers.persistent-data.index")
local usePersistentValue = ____persistent_2Ddata.usePersistentValue
local ____argparser = require("lua.helpers.user_command.argparser")
local parseArgs = ____argparser.parseArgs
function reloadConfiguration()
    local config = getGlobalConfig()
    if #__TS__ObjectKeys(config) < 1 or true then
        configuration = ____exports.CONFIGURATION_DEFAULTS
        ____exports.saveGlobalConfiguration()
        configuration = getGlobalConfig()
    else
        configuration = config
    end
end
function saveConfiguration()
    setGlobalConfig(configuration)
end
function ____exports.getGlobalConfiguration()
    if configuration == nil then
        reloadConfiguration()
    end
    return configuration
end
function ____exports.saveGlobalConfiguration()
    saveConfiguration()
end
configuration = nil
getGlobalConfig, setGlobalConfig = unpack(usePersistentValue("configuration.json", {}))
____exports.CONFIGURATION_DEFAULTS = {
    theme = {key = "TokyoNight"},
    packages = {
        mason = {enabled = not isRunningUnderNixOS()},
        nvimTree = {enabled = true},
        floatTerm = {enabled = true},
        autoPairs = {enabled = true},
        lspConfig = {enabled = true},
        treeSitter = {enabled = true},
        lspLines = {enabled = false},
        cmp = {enabled = true},
        telescope = {enabled = true},
        lspUI = {enabled = false},
        rustaceanvim = {enabled = false},
        lspSignature = {enabled = true},
        indentBlankline = {enabled = true},
        treeDevIcons = {enabled = true},
        luaLine = {enabled = true},
        barBar = {enabled = true},
        comments = {enabled = true},
        marks = {enabled = true},
        trouble = {enabled = true},
        outline = {enabled = true},
        glance = {enabled = true},
        nvimDapUI = {enabled = true, config = {lldb = {port = 1828}}},
        diffView = {enabled = true},
        lazyGit = {enabled = true},
        noice = {enabled = false},
        nvimNotify = {enabled = true},
        copilot = {enabled = false},
        actionsPreview = {enabled = true},
        fireNvim = {enabled = true},
        ufo = {enabled = true},
        lspconfig = {enabled = true, config = {inlayHints = {enabled = true, displayMode = "always"}}},
        markdownPreview = {enabled = true},
        gitBrowse = {enabled = true},
        obsidian = {enabled = false, config = {workspaces = {{name = "notes", path = "~/Documents/obsidian/notes"}}}},
        undoTree = {enabled = true},
        octo = {enabled = true},
        leap = {enabled = false},
        cSharp = {enabled = true},
        telescopeUISelect = {enabled = true},
        masonNvimDap = {enabled = false},
        timeTracker = {enabled = false},
        wakaTime = {enabled = true},
        surround = {enabled = true},
        tsAutoTag = {enabled = true},
        ultimateAutoPair = {enabled = true},
        rainbowDelimiters = {enabled = false},
        markview = {enabled = true},
        symbolUsage = {enabled = true},
        neotest = {enabled = true},
        navic = {enabled = true},
        illuminate = {enabled = false},
        treesj = {enabled = true},
        iconPicker = {enabled = true},
        todoComments = {enabled = true},
        crates = {enabled = true, config = {bleedingEdge = false}},
        dbee = {enabled = true},
        lightbulb = {enabled = false},
        neogen = {enabled = true},
        tsContextCommentString = {enabled = true},
        nvimDapVirtualText = {enabled = true},
        overseer = {enabled = false},
        hlchunk = {enabled = true},
        rest = {enabled = true},
        flatten = {enabled = true},
        tinyInlineDiagnostic = {enabled = true},
        screenkey = {enabled = true},
        hex = {enabled = true},
        fidget = {enabled = true},
        treesitterContext = {enabled = true},
        gotoPreview = {enabled = true}
    },
    targetEnvironments = {
        typescript = {enabled = true},
        deno = {enabled = false},
        ["c/c++"] = {enabled = true},
        markdown = {enabled = true},
        lua = {enabled = true},
        yaml = {enabled = true},
        rust = {enabled = true},
        bash = {enabled = true}
    },
    shell = {target = "tmux", isolationScope = "isolated"},
    integrations = {ollama = {enabled = false}}
}
local watchers = {}
function ____exports.useConfigWatcher(key, watcher)
    watchers[#watchers + 1] = {key, watcher}
    local parts = __TS__ArrayReverse(__TS__StringSplit(key, "."))
    local function currentTarget()
        return parts[#parts]
    end
    local current = ____exports.getGlobalConfiguration()
    while #parts > 1 do
        current = current[currentTarget()]
        table.remove(parts)
    end
    watcher(current, key)
end
vim.api.nvim_create_user_command(
    "Configuration",
    function(_args)
        local args = parseArgs(_args.fargs)
        if args.mode == "delete" then
            local parts = __TS__ArrayReverse(__TS__StringSplit(args.key, "."))
            local function currentTarget()
                return parts[#parts]
            end
            local current = ____exports.getGlobalConfiguration()
            while #parts > 1 do
                local next = current[currentTarget()]
                if next == nil then
                    next = {}
                    current[currentTarget()] = next
                    current = next
                else
                    current = next
                end
                table.remove(parts)
            end
            current[currentTarget()] = nil
            for ____, watcher in ipairs(__TS__ArrayFilter(
                watchers,
                function(____, x) return __TS__StringIncludes(x[1], args.key) end
            )) do
                watcher[2](nil, args.key)
            end
            ____exports.saveGlobalConfiguration()
        elseif args.mode == "list" then
            if args.key == nil then
                args.key = ""
            end
            local parts = __TS__ArrayReverse(__TS__StringSplit(args.key, "."))
            if args.key == "" then
                parts = {}
            end
            local function currentTarget()
                return parts[#parts]
            end
            local current = ____exports.getGlobalConfiguration()
            while #parts > 0 do
                current = current[currentTarget()]
                table.remove(parts)
            end
            if type(current) == "nil" then
                console.error(("Config path '" .. args.key) .. "' is undefined")
                return
            elseif type(current) == "table" then
                for key in pairs(current) do
                    console.log(((((("'" .. key) .. "': <") .. tostring(current[key])) .. "> (") .. __TS__TypeOf(current[key])) .. ")")
                end
            else
                console.log(tostring(current))
            end
        elseif args.mode == "get" then
            local parts = __TS__ArrayReverse(__TS__StringSplit(args.key, "."))
            local function currentTarget()
                return parts[#parts]
            end
            local current = ____exports.getGlobalConfiguration()
            while #parts > 1 do
                current = current[currentTarget()]
                table.remove(parts)
            end
            console.log(tostring(current[parts[1]]))
        elseif args.mode == "set" then
            local parts = __TS__ArrayReverse(__TS__StringSplit(args.key, "."))
            local function currentTarget()
                return parts[#parts]
            end
            local current = ____exports.getGlobalConfiguration()
            while #parts > 1 do
                local next = current[currentTarget()]
                if next == nil then
                    next = {}
                    current[currentTarget()] = next
                    current = next
                else
                    current = next
                end
                table.remove(parts)
            end
            local currentType = args.type or __TS__TypeOf(current[currentTarget()])
            if currentType == "undefined" then
                console.error("Cannot infer desired type from existing value: does not exist. ")
                console.error("Supply --type 'string' | 'number' | 'boolean' argument")
                return
            end
            if currentType == "string" then
                current[currentTarget()] = args.value
            elseif currentType == "boolean" then
                current[currentTarget()] = args.value == "true"
            elseif currentType == "number" then
                current[currentTarget()] = tonumber(args.value)
            else
                error(
                    __TS__New(Error, ("Cannot convert target type to " .. currentType) .. ": unsupported"),
                    0
                )
            end
            for ____, watcher in ipairs(__TS__ArrayFilter(
                watchers,
                function(____, x) return __TS__StringIncludes(x[1], args.key) end
            )) do
                watcher[2](
                    current[currentTarget()],
                    args.key
                )
            end
            ____exports.saveGlobalConfiguration()
        else
            local target = args.mode
            if target == nil then
                console.warn("Argument 'mode' is required, either get or set")
            else
                console.error(("Mode '" .. tostring(target)) .. "' is unsupported")
            end
        end
    end,
    {nargs = "*"}
)
return ____exports
 end,
["lua.custom.tmux.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__StringReplace = ____lualib.__TS__StringReplace
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____nui = require("lua.plugins.nui")
local useNUI = ____nui.useNUI
local ____fs = require("lua.shims.fs.index")
local fs = ____fs.fs
local function setTmuxScope(isolationScope)
    local globalConfig = getGlobalConfiguration()
    if isolationScope == "global" then
        vim.o.shell = "tmux"
        globalConfig.shell.isolationScope = "global"
    elseif isolationScope == "neovim-shared" then
        vim.o.shell = "tmux -L neovim"
        globalConfig.shell.isolationScope = "neovim-shared"
    elseif isolationScope == "per-instance" then
        vim.o.shell = "tmux -L neovim-" .. tostring(vim.fn.getpid())
        globalConfig.shell.isolationScope = "isolated"
    else
        error(
            __TS__New(Error, "Invalid scope " .. isolationScope),
            0
        )
    end
end
local function changeTmuxScope()
    local NUI = useNUI()
    local menu = NUI.Menu(
        {position = "50%", size = {width = 33, height = 3}, border = {style = "single", text = {top = "Change TMUX scope"}}},
        {
            lines = {
                NUI.Menu.item("Global", {target = "global"}),
                NUI.Menu.item("Shared between neovim instances", {target = "neovim-shared"}),
                NUI.Menu.item("Isolated", {target = "per-instance"})
            },
            on_submit = function(_item)
                local item = _item
                setTmuxScope(item.target)
            end
        }
    )
    menu:mount()
end
local function pruneDeadTmuxSockets()
    local SOCKET_DIR = vim.env.TMUX_TMPDIR or "/tmp"
    local userID = vim.loop.getuid()
    local socketsDirectory = (SOCKET_DIR .. "/tmux-") .. tostring(userID)
    vim.fn.system({"bash", "-c", ("rm -f " .. socketsDirectory) .. "/*"})
    vim.fn.system({"pkill", "-USR1", "tmux"})
end
function ____exports.selectCustomTmuxScope()
    local ____opt_0 = getGlobalConfiguration().packages.floatTerm
    if ____opt_0 and ____opt_0.enabled then
        do
            pcall(function()
                vim.cmd("FloatermKill!")
            end)
        end
    end
    pruneDeadTmuxSockets()
    local SOCKET_DIR = vim.env.TMUX_TMPDIR or "/tmp"
    local userID = vim.loop.getuid()
    local socketsDirectory = (SOCKET_DIR .. "/tmux-") .. tostring(userID)
    local entries = fs.readdirSync(socketsDirectory)
    vim.ui.select(
        entries,
        {
            prompt = "Select a session",
            format_item = function(item)
                local label = __TS__StringReplace(item.path, socketsDirectory .. "/", "")
                if __TS__StringIncludes(
                    item.path,
                    tostring(vim.fn.getpid())
                ) then
                    return label .. " -- Instance Pair"
                else
                    return label
                end
            end
        },
        function(choice)
            if choice == nil then
                return
            end
            local id = __TS__StringReplace(choice.path, socketsDirectory .. "/", "")
            vim.g.terminal_emulator = "tmux -L " .. id
            local ____opt_2 = getGlobalConfiguration().packages.floatTerm
            if ____opt_2 and ____opt_2.enabled then
                do
                    pcall(function()
                        vim.cmd("FloatermKill!")
                        vim.g.floaterm_title = "tmux " .. id
                    end)
                end
            end
            console.log(vim.g.terminal_emulator)
        end
    )
end
function ____exports.isRunningInsideTmux()
    local ____opt_4 = os.getenv("TERM")
    if ____opt_4 and __TS__StringIncludes(
        os.getenv("TERM"),
        "tmux"
    ) then
        return true
    else
        return false
    end
end
function ____exports.initCustomTmux()
    local shellConfig = getGlobalConfiguration().shell
    if shellConfig.target == "tmux" then
        local term = os.getenv("TERM") or "__term_value_not_supplied"
        if not __TS__StringIncludes(term, "tmux") then
            vim.g.terminal_emulator = "tmux"
            local isolationScope = shellConfig.isolationScope
            if isolationScope == "global" then
                vim.o.shell = "tmux"
            elseif isolationScope == "neovim-shared" then
                vim.o.shell = "tmux -L neovim"
            elseif isolationScope == "isolated" then
                vim.o.shell = "tmux -L neovim-" .. tostring(vim.fn.getpid())
            else
                vim.notify(("Invalid option '" .. tostring(isolationScope)) .. "' for tmux isolation scope.")
                vim.o.shell = "tmux"
            end
        else
        end
    end
    vim.api.nvim_create_user_command("ChangeTmuxScope", changeTmuxScope, {})
    vim.api.nvim_create_user_command("SelectTmuxScope", ____exports.selectCustomTmuxScope, {})
    vim.api.nvim_create_user_command("PruneTmuxInstanceSockets", pruneDeadTmuxSockets, {})
end
return ____exports
 end,
["lua.custom.index"] = function(...) 
local ____exports = {}
local ____custom_2Dopen = require("lua.custom.custom-open.index")
local initCustomOpen = ____custom_2Dopen.initCustomOpen
local ____env_2Dload = require("lua.custom.env-load.index")
local initCustomEnvLoader = ____env_2Dload.initCustomEnvLoader
local ____git = require("lua.custom.git.index")
local initCustomGit = ____git.initCustomGit
local ____jumplist = require("lua.custom.jumplist.index")
local initCustomJumplist = ____jumplist.initCustomJumplist
local ____profile = require("lua.custom.profile.index")
local setupCustomProfilerCommands = ____profile.setupCustomProfilerCommands
local ____tmux = require("lua.custom.tmux.index")
local initCustomTmux = ____tmux.initCustomTmux
function ____exports.setupCustomLogic()
    initCustomTmux()
    initCustomOpen()
    initCustomEnvLoader()
    initCustomJumplist()
    initCustomGit()
    setupCustomProfilerCommands()
end
return ____exports
 end,
["lua.integrations.neovide"] = function(...) 
local ____exports = {}
function ____exports.isNeovideSession()
    return vim.g.neovide ~= nil
end
function ____exports.getNeovideExtendedVimContext()
    return vim
end
return ____exports
 end,
["lua.helpers.font.index"] = function(...) 
local ____exports = {}
local ____neovide = require("lua.integrations.neovide")
local getNeovideExtendedVimContext = ____neovide.getNeovideExtendedVimContext
local isNeovideSession = ____neovide.isNeovideSession
function ____exports.setGUIFont(fontName, fontSize)
    if isNeovideSession() then
        local opts = getNeovideExtendedVimContext()
        opts.o.guifont = (fontName .. ":h") .. tostring(fontSize)
    else
        vim.notify("Cannot update GUI font: feature is only available in a Neovide context", vim.log.levels.ERROR)
    end
end
return ____exports
 end,
["lua.integrations.hyprland"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__StringTrim = ____lualib.__TS__StringTrim
local __TS__StringSplit = ____lualib.__TS__StringSplit
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local __TS__StringIncludes = ____lualib.__TS__StringIncludes
local __TS__ArrayFilter = ____lualib.__TS__ArrayFilter
local __TS__Number = ____lualib.__TS__Number
local ____exports = {}
function ____exports.isDesktopHyprland()
    return os.getenv("HYPRLAND_INSTANCE_SIGNATURE") ~= nil
end
local function getRefreshRates()
    local out = __TS__ArrayMap(
        __TS__StringSplit(
            vim.fn.system({"hyprctl", "monitors"}),
            "\n"
        ),
        function(____, x) return __TS__StringTrim(x) end
    )
    local targets = __TS__ArrayFilter(
        __TS__ArrayMap(
            __TS__ArrayFilter(
                out,
                function(____, x) return not __TS__StringIncludes(x, ":") end
            ),
            function(____, x) return __TS__StringTrim(x) end
        ),
        function(____, x) return #x > 0 end
    )
    local function extractRefreshRate(line)
        local resAndRefresh = unpack(__TS__StringSplit(line, " at "))
        local resolution, refreshRate = unpack(__TS__StringSplit(resAndRefresh, "@"))
        return __TS__Number(refreshRate)
    end
    return __TS__ArrayMap(
        targets,
        function(____, x) return extractRefreshRate(x) end
    )
end
____exports.Hyprland = {getRefreshRates = getRefreshRates}
return ____exports
 end,
["lua.plugins.copilot"] = function(...) 
local ____exports = {}
function ____exports.getCopilotExtendedVimAPI()
    return vim
end
local plugin = {
    [1] = "github/copilot.vim",
    event = "VeryLazy",
    config = function()
        local vim = ____exports.getCopilotExtendedVimAPI()
        vim.g.copilot_no_tab_map = true
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.shims.mainLoopCallbacks"] = function(...) 
local ____exports = {}
function ____exports.setTimeout(callback, ms)
    local cancelFlag = false
    local function cancel()
        cancelFlag = true
    end
    local function wrapper()
        if not cancelFlag then
            callback()
        end
    end
    vim.defer_fn(wrapper, ms)
    return cancel
end
function ____exports.setImmediate(callback)
    return vim.schedule(callback)
end
function ____exports.setInterval(callback, interval)
    local cancelFlag = false
    local wrapper
    wrapper = function()
        if not cancelFlag then
            callback()
            ____exports.setTimeout(wrapper, interval)
        end
    end
    local function cancel()
        cancelFlag = true
    end
    ____exports.setTimeout(wrapper, interval)
    return cancel
end
function ____exports.clearTimeout(handle)
    handle()
end
function ____exports.clearInterval(handle)
    handle()
end
function ____exports.insertMainLoopCallbackShims()
    local global = _G
    global.setTimeout = ____exports.setTimeout
    global.clearTimeout = ____exports.clearTimeout
    global.setInterval = ____exports.setInterval
    global.clearInterval = ____exports.clearInterval
    global.setImmediate = ____exports.setImmediate
end
return ____exports
 end,
["lua.integrations.ollama"] = function(...) 
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____copilot = require("lua.plugins.copilot")
local getCopilotExtendedVimAPI = ____copilot.getCopilotExtendedVimAPI
local ____mainLoopCallbacks = require("lua.shims.mainLoopCallbacks")
local setImmediate = ____mainLoopCallbacks.setImmediate
function ____exports.setupOllamaCopilot()
    local vim = getCopilotExtendedVimAPI()
    local ____opt_0 = getGlobalConfiguration().integrations.ollama
    if not (____opt_0 and ____opt_0.enabled) then
        return
    end
    local ____opt_2 = getGlobalConfiguration().packages.copilot
    if not (____opt_2 and ____opt_2.enabled) then
        return
    end
    vim.g.copilot_proxy = "http://localhost:11435"
    vim.g.copilot_proxy_strict_ssl = false
    if not vim.fn.executable("go") then
        vim.notify("Cannot configure copilot ollama proxy: the `go` binary is not installed", vim.log.levels.ERROR)
        return
    end
    vim.fn.system({"go", "install", "github.com/bernardo-bruning/ollama-copilot@latest"})
    if vim.v.shell_error ~= 0 then
        vim.notify("An error occurred while installing `ollama-copilot@latest`.", vim.log.levels.ERROR)
        return
    end
    local username = os.getenv("USER")
    if username == nil then
        vim.notify("$USER var is unset", vim.log.levels.ERROR)
        return
    end
    local ollamaPath = ("/home/" .. username) .. "/go/bin/ollama-copilot"
    if not vim.fn.executable(ollamaPath) then
        vim.notify("Unable to locate ollama-copilot binary")
        return
    end
    local handle
    handle = vim.loop.spawn(
        ollamaPath,
        {detached = true},
        function(code, signal)
            setImmediate(function()
                vim.notify(((("ollama exited: signal(" .. tostring(signal)) .. ") code(") .. tostring(code)) .. ")")
            end)
            handle:close()
        end
    )
end
return ____exports
 end,
["lua.integrations.portable-appimage"] = function(...) 
local ____exports = {}
local function getAppImageConfigData()
    return {appDir = os.getenv("APPDIR")}
end
local function injectSTDPathOverride()
    vim.fn.stdpath = function(target)
        return "/tmp/winvim/" .. target
    end
end
function ____exports.enablePortableAppImageLogic()
    local appImageEnvironment = getAppImageConfigData()
    if appImageEnvironment.appDir ~= nil then
        injectSTDPathOverride()
    end
end
return ____exports
 end,
["lua.plugins.init"] = function(...) 
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
function ____exports.getPlugins()
    local globalConfig = getGlobalConfiguration()
    local result = {}
    result[#result + 1] = require("lua.plugins.tokyonight").default
    result[#result + 1] = require("lua.plugins.catppuccin").default
    result[#result + 1] = require("lua.plugins.theme-flow").default
    result[#result + 1] = require("lua.plugins.kanagawa").default
    result[#result + 1] = require("lua.plugins.nord").default
    local ____opt_0 = globalConfig.packages.treeSitter
    if ____opt_0 and ____opt_0.enabled then
        result[#result + 1] = require("lua.plugins.treesitter").default
    end
    local ____opt_2 = globalConfig.packages.lspConfig
    if ____opt_2 and ____opt_2.enabled then
        result[#result + 1] = require("lua.plugins.lspconfig").default
    end
    local ____opt_4 = globalConfig.packages.autoPairs
    if ____opt_4 and ____opt_4.enabled then
        result[#result + 1] = require("lua.plugins.autopairs").default
    end
    local ____opt_6 = globalConfig.packages.floatTerm
    if ____opt_6 and ____opt_6.enabled then
        result[#result + 1] = require("lua.plugins.floatterm").default
    end
    local ____opt_8 = globalConfig.packages.nvimTree
    if ____opt_8 and ____opt_8.enabled then
        result[#result + 1] = require("lua.plugins.nvim-tree").default
    end
    local ____opt_10 = globalConfig.packages.telescope
    if ____opt_10 and ____opt_10.enabled then
        result[#result + 1] = require("lua.plugins.mason").default
    end
    local ____opt_12 = globalConfig.packages.telescope
    if ____opt_12 and ____opt_12.enabled then
        result[#result + 1] = require("lua.plugins.telescope").default
    end
    local ____opt_14 = globalConfig.packages.cmp
    if ____opt_14 and ____opt_14.enabled then
        result[#result + 1] = require("lua.plugins.cmp").default
    end
    local ____opt_16 = globalConfig.packages.lspLines
    if ____opt_16 and ____opt_16.enabled then
        result[#result + 1] = require("lua.plugins.lsp_lines").default
    end
    local ____opt_18 = globalConfig.packages.lspUI
    if ____opt_18 and ____opt_18.enabled then
        result[#result + 1] = require("lua.plugins.lspUI").default
    end
    local ____opt_20 = globalConfig.packages.rustaceanvim
    if ____opt_20 and ____opt_20.enabled then
        result[#result + 1] = require("lua.plugins.rustaceanvim").default
    end
    local ____opt_22 = globalConfig.packages.lspSignature
    if ____opt_22 and ____opt_22.enabled then
        result[#result + 1] = require("lua.plugins.lsp_signature").default
    end
    local ____opt_24 = globalConfig.packages.indentBlankline
    if ____opt_24 and ____opt_24.enabled then
        result[#result + 1] = require("lua.plugins.indent-blankline").default
    end
    local ____opt_26 = globalConfig.packages.treeDevIcons
    if ____opt_26 and ____opt_26.enabled then
        result[#result + 1] = require("lua.plugins.nvim-tree-devicons").default
    end
    local ____opt_28 = globalConfig.packages.luaLine
    if ____opt_28 and ____opt_28.enabled then
        result[#result + 1] = require("lua.plugins.lualine").default
    end
    local ____opt_30 = globalConfig.packages.barBar
    if ____opt_30 and ____opt_30.enabled then
        result[#result + 1] = require("lua.plugins.barbar").default
    end
    local ____opt_32 = globalConfig.packages.ufo
    if ____opt_32 and ____opt_32.enabled then
        result[#result + 1] = require("lua.plugins.ufo").default
    end
    local ____opt_34 = globalConfig.packages.comments
    if ____opt_34 and ____opt_34.enabled then
        result[#result + 1] = require("lua.plugins.comment").default
    end
    local ____opt_36 = globalConfig.packages.marks
    if ____opt_36 and ____opt_36.enabled then
        result[#result + 1] = require("lua.plugins.marks").default
    end
    local ____opt_38 = globalConfig.packages.trouble
    if ____opt_38 and ____opt_38.enabled then
        result[#result + 1] = require("lua.plugins.trouble").default
    end
    local ____opt_40 = globalConfig.packages.outline
    if ____opt_40 and ____opt_40.enabled then
        result[#result + 1] = require("lua.plugins.outline").default
    end
    local ____opt_42 = globalConfig.packages.glance
    if ____opt_42 and ____opt_42.enabled then
        result[#result + 1] = require("lua.plugins.glance").default
    end
    local ____opt_44 = globalConfig.packages.nvimDapUI
    if ____opt_44 and ____opt_44.enabled then
        result[#result + 1] = require("lua.plugins.nvim-dap-ui").default
    end
    local ____opt_46 = globalConfig.packages.diffView
    if ____opt_46 and ____opt_46.enabled then
        result[#result + 1] = require("lua.plugins.diffview").default
    end
    local ____opt_48 = globalConfig.packages.lazyGit
    if ____opt_48 and ____opt_48.enabled then
        result[#result + 1] = require("lua.plugins.lazygit").default
    end
    local ____opt_50 = globalConfig.packages.noice
    if ____opt_50 and ____opt_50.enabled then
        result[#result + 1] = require("lua.plugins.noice").default
    end
    local ____opt_52 = globalConfig.packages.copilot
    if ____opt_52 and ____opt_52.enabled then
        result[#result + 1] = require("lua.plugins.copilot").default
    end
    local ____opt_54 = globalConfig.packages.actionsPreview
    if ____opt_54 and ____opt_54.enabled then
        result[#result + 1] = require("lua.plugins.actions-preview").default
    end
    local ____opt_56 = globalConfig.packages.fireNvim
    if ____opt_56 and ____opt_56.enabled then
        result[#result + 1] = require("lua.plugins.firenvim").default
    end
    local ____opt_58 = globalConfig.packages.nvimNotify
    if ____opt_58 and ____opt_58.enabled then
        result[#result + 1] = require("lua.plugins.nvim-notify").default
    end
    local ____opt_60 = globalConfig.packages.markdownPreview
    if ____opt_60 and ____opt_60.enabled then
        result[#result + 1] = require("lua.plugins.markdown-preview").default
    end
    local ____opt_62 = globalConfig.packages.gitBrowse
    if ____opt_62 and ____opt_62.enabled then
        result[#result + 1] = require("lua.plugins.git-browse").default
    end
    local ____opt_64 = globalConfig.packages.obsidian
    if ____opt_64 and ____opt_64.enabled then
        result[#result + 1] = require("lua.plugins.obsidian").default
    end
    local ____opt_66 = globalConfig.packages.undoTree
    if ____opt_66 and ____opt_66.enabled then
        result[#result + 1] = require("lua.plugins.undotree").default
    end
    local ____opt_68 = globalConfig.packages.octo
    if ____opt_68 and ____opt_68.enabled then
        result[#result + 1] = require("lua.plugins.octo").default
    end
    local ____opt_70 = globalConfig.packages.leap
    if ____opt_70 and ____opt_70.enabled then
        result[#result + 1] = require("lua.plugins.leap").default
    end
    local ____opt_72 = globalConfig.packages.cSharp
    if ____opt_72 and ____opt_72.enabled then
        result[#result + 1] = require("lua.plugins.csharp").default
    end
    local ____opt_74 = globalConfig.packages.telescopeUISelect
    if ____opt_74 and ____opt_74.enabled then
        result[#result + 1] = require("lua.plugins.telescope-ui-select").default
    end
    local ____opt_76 = globalConfig.packages.masonNvimDap
    if ____opt_76 and ____opt_76.enabled then
        result[#result + 1] = require("lua.plugins.mason-nvim-dap").default
    end
    local ____opt_78 = globalConfig.packages.timeTracker
    if ____opt_78 and ____opt_78.enabled then
        result[#result + 1] = require("lua.plugins.time-tracker").default
    end
    local ____opt_80 = globalConfig.packages.wakaTime
    if ____opt_80 and ____opt_80.enabled then
        result[#result + 1] = require("lua.plugins.wakatime").default
    end
    local ____opt_82 = globalConfig.packages.surround
    if ____opt_82 and ____opt_82.enabled then
        result[#result + 1] = require("lua.plugins.surround").default
    end
    local ____opt_84 = globalConfig.packages.tsAutoTag
    if ____opt_84 and ____opt_84.enabled then
        result[#result + 1] = require("lua.plugins.ts-autotag").default
    end
    local ____opt_86 = globalConfig.packages.ultimateAutoPair
    if ____opt_86 and ____opt_86.enabled then
        result[#result + 1] = require("lua.plugins.ultimate-autopair").default
    end
    local ____opt_88 = globalConfig.packages.rainbowDelimiters
    if ____opt_88 and ____opt_88.enabled then
        result[#result + 1] = require("lua.plugins.rainbow-delimiters").default
    end
    local ____opt_90 = globalConfig.packages.markview
    if ____opt_90 and ____opt_90.enabled then
        result[#result + 1] = require("lua.plugins.markview").default
    end
    local ____opt_92 = globalConfig.packages.symbolUsage
    if ____opt_92 and ____opt_92.enabled then
        result[#result + 1] = require("lua.plugins.symbol-usage").default
    end
    local ____opt_94 = globalConfig.packages.neotest
    if ____opt_94 and ____opt_94.enabled then
        result[#result + 1] = require("lua.plugins.neotest").default
    end
    local ____opt_96 = globalConfig.packages.navic
    if ____opt_96 and ____opt_96.enabled then
        result[#result + 1] = require("lua.plugins.navic").default
    end
    local ____opt_98 = globalConfig.packages.illuminate
    if ____opt_98 and ____opt_98.enabled then
        result[#result + 1] = require("lua.plugins.illuminate").default
    end
    local ____opt_100 = globalConfig.packages.treesj
    if ____opt_100 and ____opt_100.enabled then
        result[#result + 1] = require("lua.plugins.treesj").default
    end
    local ____opt_102 = globalConfig.packages.iconPicker
    if ____opt_102 and ____opt_102.enabled then
        result[#result + 1] = require("lua.plugins.icon-picker").default
    end
    local ____opt_104 = globalConfig.packages.todoComments
    if ____opt_104 and ____opt_104.enabled then
        result[#result + 1] = require("lua.plugins.todo-comments").default
    end
    local ____opt_106 = globalConfig.packages.crates
    if ____opt_106 and ____opt_106.enabled then
        result[#result + 1] = require("lua.plugins.crates").default
    end
    local ____opt_108 = globalConfig.packages.dbee
    if ____opt_108 and ____opt_108.enabled then
        result[#result + 1] = require("lua.plugins.dbee").default
    end
    local ____opt_110 = globalConfig.packages.lightbulb
    if ____opt_110 and ____opt_110.enabled then
        result[#result + 1] = require("lua.plugins.lightbulb").default
    end
    local ____opt_112 = globalConfig.packages.neogen
    if ____opt_112 and ____opt_112.enabled then
        result[#result + 1] = require("lua.plugins.neogen").default
    end
    local ____opt_114 = globalConfig.packages.tsContextCommentString
    if ____opt_114 and ____opt_114.enabled then
        result[#result + 1] = require("lua.plugins.ts-context-commentstring").default
    end
    local ____opt_116 = globalConfig.packages.nvimDapVirtualText
    if ____opt_116 and ____opt_116.enabled then
        result[#result + 1] = require("lua.plugins.dap-virtual-text").default
    end
    local ____opt_118 = globalConfig.packages.overseer
    if ____opt_118 and ____opt_118.enabled then
        result[#result + 1] = require("lua.plugins.overseer").default
    end
    local ____opt_120 = globalConfig.packages.hlchunk
    if ____opt_120 and ____opt_120.enabled then
        result[#result + 1] = require("lua.plugins.hlchunk").default
    end
    local ____opt_122 = globalConfig.packages.rest
    if ____opt_122 and ____opt_122.enabled then
        result[#result + 1] = require("lua.plugins.rest").default
    end
    local ____opt_124 = globalConfig.packages.flatten
    if ____opt_124 and ____opt_124.enabled then
        result[#result + 1] = require("lua.plugins.flatten").default
    end
    local ____opt_126 = globalConfig.packages.tinyInlineDiagnostic
    if ____opt_126 and ____opt_126.enabled then
        result[#result + 1] = require("lua.plugins.tiny-inline-diagnostic").default
    end
    local ____opt_128 = globalConfig.packages.screenkey
    if ____opt_128 and ____opt_128.enabled then
        result[#result + 1] = require("lua.plugins.screenkey").default
    end
    local ____opt_130 = globalConfig.packages.hex
    if ____opt_130 and ____opt_130.enabled then
        result[#result + 1] = require("lua.plugins.hex").default
    end
    local ____opt_132 = globalConfig.packages.fidget
    if ____opt_132 and ____opt_132.enabled then
        result[#result + 1] = require("lua.plugins.fidget").default
    end
    local ____opt_134 = globalConfig.packages.treesitterContext
    if ____opt_134 and ____opt_134.enabled then
        result[#result + 1] = require("lua.plugins.treesitter-context").default
    end
    local ____opt_136 = globalConfig.packages.gotoPreview
    if ____opt_136 and ____opt_136.enabled then
        result[#result + 1] = require("lua.plugins.goto-preview").default
    end
    result[#result + 1] = require("lua.plugins.nui").default
    return result
end
return ____exports
 end,
["lua.shims.console.index"] = function(...) 
local ____exports = {}
function ____exports.insertConsoleShims()
    if _G.console == nil then
        _G.console = {}
    end
    _G.console.log = function(message)
        vim.notify(message, vim.log.levels.INFO)
    end
    _G.console.warn = function(message)
        vim.notify(message, vim.log.levels.WARN)
    end
    _G.console.error = function(message)
        vim.notify(message, vim.log.levels.ERROR)
    end
end
return ____exports
 end,
["lua.shims.json.index"] = function(...) 
local ____exports = {}
function ____exports.insertJSONShims()
    if _G.JSON == nil then
        _G.JSON = {}
    end
    _G.JSON.stringify = function(____, value, replacer)
        if replacer ~= nil then
            vim.notify("JSON.stringify replacer param does not have shim implementation", vim.log.levels.ERROR)
        end
        return vim.json.encode(value)
    end
    _G.JSON.parse = function(____, text, reviver)
        if reviver ~= nil then
            vim.notify("JSON.parse reviver param does not have shim implementation", vim.log.levels.ERROR)
        end
        vim.json.decode(text)
    end
end
return ____exports
 end,
["main"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__SparseArrayNew = ____lualib.__TS__SparseArrayNew
local __TS__SparseArrayPush = ____lualib.__TS__SparseArrayPush
local __TS__SparseArraySpread = ____lualib.__TS__SparseArraySpread
local ____exports = {}
local ____custom = require("lua.custom.index")
local setupCustomLogic = ____custom.setupCustomLogic
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____font = require("lua.helpers.font.index")
local setGUIFont = ____font.setGUIFont
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____hyprland = require("lua.integrations.hyprland")
local Hyprland = ____hyprland.Hyprland
local isDesktopHyprland = ____hyprland.isDesktopHyprland
local ____neovide = require("lua.integrations.neovide")
local getNeovideExtendedVimContext = ____neovide.getNeovideExtendedVimContext
local ____ollama = require("lua.integrations.ollama")
local setupOllamaCopilot = ____ollama.setupOllamaCopilot
local ____portable_2Dappimage = require("lua.integrations.portable-appimage")
local enablePortableAppImageLogic = ____portable_2Dappimage.enablePortableAppImageLogic
local ____init = require("lua.plugins.init")
local getPlugins = ____init.getPlugins
local ____console = require("lua.shims.console.index")
local insertConsoleShims = ____console.insertConsoleShims
local ____json = require("lua.shims.json.index")
local insertJSONShims = ____json.insertJSONShims
local ____mainLoopCallbacks = require("lua.shims.mainLoopCallbacks")
local insertMainLoopCallbackShims = ____mainLoopCallbacks.insertMainLoopCallbackShims
local setImmediate = ____mainLoopCallbacks.setImmediate
local ____theme = require("lua.theme")
local THEME_APPLIERS = ____theme.THEME_APPLIERS
insertJSONShims()
insertConsoleShims()
insertMainLoopCallbackShims()
enablePortableAppImageLogic()
local function setupNeovide()
    local vim = getNeovideExtendedVimContext()
    if vim.g.neovide then
        vim.g.neovide_scale_factor = 0.85
        vim.g.neovide_detach_on_quit = "always_detach"
        if isDesktopHyprland() then
            local ____array_0 = __TS__SparseArrayNew(unpack(Hyprland.getRefreshRates()))
            __TS__SparseArrayPush(____array_0, 60)
            local targetRefresh = math.max(unpack({__TS__SparseArraySpread(____array_0)}))
            vim.g.neovide_refresh_rate = targetRefresh
        end
        setGUIFont("VictorMono_Nerd_Font_Mono", 14)
    end
end
local function setupLazy()
    local lazyPath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not vim.loop.fs_stat(lazyPath) then
        local repo = "https://github.com/folke/lazy.nvim.git"
        vim.fn.system({
            "git",
            "clone",
            "--filter=blob:none",
            repo,
            "--branch=stable",
            lazyPath
        })
    end
    vim.opt.rtp:prepend(lazyPath)
end
setupNeovide()
setupOllamaCopilot()
local ____opt_1 = getGlobalConfiguration().packages.copilot
local ____temp_3 = ____opt_1 and ____opt_1.enabled
if ____temp_3 == nil then
    ____temp_3 = false
end
if not ____temp_3 then
    vim.g.copilot_filetypes = {["*"] = false}
end
setupLazy()
local lazy = useExternalModule("lazy")
lazy.setup(getPlugins())
THEME_APPLIERS[getGlobalConfiguration().theme.key]()
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "number"
vim.opt.numberwidth = 2
vim.opt.ruler = false
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
require("mappings")
setImmediate(setupCustomLogic)
return ____exports
 end,
["lua.helpers.one-off.index"] = function(...) 
local ____exports = {}
local ____fs = require("lua.shims.fs.index")
local fs = ____fs.fs
local dataPath = vim.fn.stdpath("data") .. "/winvim/one-off"
vim.fn.system({"mkdir", "-p", dataPath})
function ____exports.oneOffFunction(key, only_once, not_first_time)
    local path = (dataPath .. "/") .. key
    if fs.existsSync(path) then
        if not_first_time ~= nil then
            not_first_time()
        end
    else
        fs.writeFileSync(path, "")
        only_once()
    end
end
return ____exports
 end,
["lua.plugins.actions-preview"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.getActionsPreview()
    local target = "actions-preview"
    local module = useExternalModule(target)
    return module
end
local plugin = {[1] = "aznhe21/actions-preview.nvim", event = "VeryLazy"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.csharp"] = function(...) 
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____mainLoopCallbacks = require("lua.shims.mainLoopCallbacks")
local setImmediate = ____mainLoopCallbacks.setImmediate
function ____exports.getCSharp()
    return useExternalModule("csharp")
end
local plugin = {
    [1] = "iabdelkareem/csharp.nvim",
    dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap", "Tastyep/structlog.nvim"},
    config = function()
        local ____opt_0 = getGlobalConfiguration().packages.mason
        if ____opt_0 and ____opt_0.enabled then
            if not vim.fn.executable("fd") then
                setImmediate(function()
                    console.error("[plugin/cSharp] Initialization not allowed: fd is required, but cannot be found in the current path.")
                end)
            else
                ____exports.getCSharp().setup()
            end
        else
            setImmediate(function()
                console.error("[plugin/cSharp] Initialization not allowed: mason is required, but has been disabled.")
            end)
        end
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nvim-dap-ui"] = function(...) 
local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__ArraySome = ____lualib.__TS__ArraySome
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.getDap()
    local target = "dap"
    local dapui = useExternalModule(target)
    return dapui
end
function ____exports.getDapUI()
    local target = "dapui"
    local dapui = useExternalModule(target)
    return dapui
end
local function bindDapUIEvents()
    local dap = ____exports.getDap()
    local dapui = ____exports.getDapUI()
    dap.listeners.before.attach.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
    end
end
local cppExePath
local function getCPPTargetExecutable()
    if cppExePath == nil then
        cppExePath = vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",
            "file"
        )
        if not vim.loop.fs_stat(cppExePath) then
            cppExePath = nil
            error(
                __TS__New(Error, "File not found"),
                0
            )
        end
    end
    return cppExePath
end
vim.api.nvim_create_autocmd(
    "DirChanged",
    {callback = function()
        cppExePath = nil
    end}
)
local function createOrUseArray(root, arrayKey, callback)
    if root[arrayKey] == nil or root[arrayKey] == nil then
        root[arrayKey] = {}
    end
    return callback(root[arrayKey])
end
local function configureLanguages()
    local dap = ____exports.getDap()
    if vim.fn.executable("codelldb") == 1 then
        dap.adapters.lldb = {type = "server", port = "${port}", host = "127.0.0.1", executable = {command = "codelldb", args = {"--port", "${port}"}}}
        for ____, language in ipairs({"c", "cpp", "rust"}) do
            createOrUseArray(
                dap.configurations,
                language,
                function(languageConfig)
                    languageConfig[#languageConfig + 1] = {
                        name = "Launch",
                        type = "lldb",
                        request = "launch",
                        program = getCPPTargetExecutable,
                        cwd = "${workspaceFolder}",
                        stopOnEntry = false,
                        args = function()
                            local result = {}
                            result[#result + 1] = "test"
                            return result
                        end,
                        runInTerminal = true
                    }
                end
            )
        end
    end
    if vim.fn.executable("js-debug-adapter") == 1 then
        dap.adapters["pwa-node"] = {type = "server", host = "::1", port = 8123, executable = {command = "js-debug-adapter"}}
        vim.notify("JS Debug Adapter installed, but no DAP configuration uses it.", vim.log.levels.WARN)
    end
    if vim.fn.executable("node-debug2-adapter") == 1 then
        dap.adapters.node2 = {name = "NodeJS Debug", type = "executable", command = "node-debug2-adapter"}
        for ____, language in ipairs({"javascript", "typescript"}) do
            dap.configurations[language] = {{
                type = "node2",
                request = "launch",
                name = "Launch file",
                program = "${file}",
                cwd = "${workspaceFolder}",
                runtimeExecutable = "node",
                outDir = "dist",
                args = {"${file}"},
                sourceMap = true,
                skipFiles = {"<node_internals>/**", "node_modules/**"},
                protocol = "inspector",
                outFiles = {"${workspaceFolder}/dist/*.js"}
            }}
        end
    end
end
local function configureActiveLanguages()
    local config = getGlobalConfiguration()
    local ____opt_0 = config.packages.nvimDapUI
    local dapConfig = ____opt_0 and ____opt_0.config
    if dapConfig == nil then
        vim.notify("DAP configuration undefined. Unable to continue setup.", vim.log.levels.ERROR)
        return
    end
    local dap = ____exports.getDap()
    local ____opt_2 = config.targetEnvironments["c/c++"]
    if ____opt_2 and ____opt_2.enabled then
        local LLDB_PORT = dapConfig.lldb.port
        dap.adapters.lldb = {
            type = "server",
            port = LLDB_PORT,
            host = dapConfig.lldb.host or "127.0.0.1",
            executable = {
                command = dapConfig.lldb.executable or "codelldb",
                args = {
                    "--port",
                    tostring(LLDB_PORT),
                    unpack(dapConfig.lldb.additionalArgs or ({}))
                }
            }
        }
        for ____, language in ipairs({"cpp", "c"}) do
            dap.configurations[language] = {{
                name = "Launch",
                type = "lldb",
                request = "launch",
                program = getCPPTargetExecutable,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                args = {},
                runInTerminal = true
            }}
        end
    end
    local possibleTargets = {"nodejs", "javascript", "typescript"}
    if __TS__ArraySome(
        possibleTargets,
        function(____, x)
            local ____opt_4 = config.targetEnvironments[x]
            local ____temp_6 = ____opt_4 and ____opt_4.enabled
            if ____temp_6 == nil then
                ____temp_6 = false
            end
            return ____temp_6
        end
    ) then
        dap.adapters["pwa-node"] = {type = "server", host = "::1", port = 8123, executable = {command = "js-debug-adapter"}}
        dap.adapters.node2 = {name = "NodeJS Debug", type = "executable", command = "node-debug2-adapter"}
        for ____, language in ipairs({"javascript", "typescript"}) do
            local ____opt_7 = config.targetEnvironments[language]
            if ____opt_7 and ____opt_7.enabled then
                dap.configurations[language] = {{
                    type = "node2",
                    request = "launch",
                    name = "Launch file",
                    program = "${file}",
                    cwd = "${workspaceFolder}",
                    runtimeExecutable = "node",
                    outDir = "dist",
                    args = {"${file}"},
                    sourceMap = true,
                    skipFiles = {"<node_internals>/**", "node_modules/**"},
                    protocol = "inspector",
                    outFiles = {"${workspaceFolder}/dist/*.js"}
                }}
            end
        end
    end
end
local plugin = {
    [1] = "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    config = function()
        ____exports.getDapUI().setup({})
        bindDapUIEvents()
        configureLanguages()
        ____exports.getDap().defaults.fallback.exception_breakpoints = {"uncaught", "raised"}
    end
}
____exports.default = plugin
return ____exports
 end,
["mappings"] = function(...) 
local ____exports = {}
local ____tmux = require("lua.custom.tmux.index")
local isRunningInsideTmux = ____tmux.isRunningInsideTmux
local selectCustomTmuxScope = ____tmux.selectCustomTmuxScope
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____keymap = require("lua.helpers.keymap.index")
local applyKeyMapping = ____keymap.applyKeyMapping
local ____one_2Doff = require("lua.helpers.one-off.index")
local oneOffFunction = ____one_2Doff.oneOffFunction
local ____actions_2Dpreview = require("lua.plugins.actions-preview")
local getActionsPreview = ____actions_2Dpreview.getActionsPreview
local ____csharp = require("lua.plugins.csharp")
local getCSharp = ____csharp.getCSharp
local ____nvim_2Ddap_2Dui = require("lua.plugins.nvim-dap-ui")
local getDap = ____nvim_2Ddap_2Dui.getDap
local getDapUI = ____nvim_2Ddap_2Dui.getDapUI
vim.g.mapleader = " "
vim.cmd("map w <Nop>")
vim.cmd("map W <Nop>")
local MOVEMENT_DIRECTION_KEYS = {left = {key = "h", command = "<Left>"}, right = {key = "l", command = "<Right>"}, up = {key = "k", command = "<Up>"}, down = {key = "j", command = "<Down>"}}
for direction in pairs(MOVEMENT_DIRECTION_KEYS) do
    local key = MOVEMENT_DIRECTION_KEYS[direction]
    applyKeyMapping({mode = "i", inputStroke = ("<C-" .. key.key) .. ">", outputStroke = key.command, options = {desc = "move " .. direction}})
end
for direction in pairs(MOVEMENT_DIRECTION_KEYS) do
    local key = MOVEMENT_DIRECTION_KEYS[direction]
    applyKeyMapping({mode = "n", inputStroke = ("<C-" .. key.key) .. ">", outputStroke = "<C-w>" .. key.key, options = {desc = "switch window " .. direction}})
end
local config = getGlobalConfiguration()
local function getPackage(key)
    local target = config.packages[key]
    if target == nil then
        return {false, nil}
    else
        return {target.enabled, target.config}
    end
end
do
    local enabled = unpack(getPackage("barBar"))
    if enabled then
        applyKeyMapping({mode = "n", inputStroke = "<leader>x", outputStroke = "<cmd>BufferClose<CR>", options = {desc = "Close current buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<Tab>", outputStroke = "<cmd>BufferNext<CR>", options = {desc = "Switch buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<A-h>", outputStroke = "<cmd>:BufferPrevious <CR>", options = {desc = "previous buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<A-l>", outputStroke = "<cmd>:BufferNext <CR>", options = {desc = "next buffer"}})
    else
        applyKeyMapping({mode = "n", inputStroke = "<leader>x", outputStroke = "<cmd>:bd<CR>:bnext<CR>", options = {desc = "Close current buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<A-h>", outputStroke = "<cmd>:bprev <CR>", options = {desc = "previous buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<A-l>", outputStroke = "<cmd>:bnext <CR>", options = {desc = "next buffer"}})
        applyKeyMapping({mode = "n", inputStroke = "<Tab>", outputStroke = "<cmd>:bnext<CR>", options = {desc = "Switch next buffer"}})
    end
end
applyKeyMapping({mode = "n", inputStroke = "<leader>s", outputStroke = "<cmd>:vsplit<CR>", options = {desc = "vertical split"}})
applyKeyMapping({mode = "n", inputStroke = "<leader>h", outputStroke = "<cmd>:split<CR>", options = {desc = "horizontal split"}})
applyKeyMapping({mode = "n", inputStroke = "<Esc>", outputStroke = "<cmd>noh<CR>", options = {desc = "general clear highlights"}})
applyKeyMapping({mode = "n", inputStroke = "<C-n>", outputStroke = "<cmd>NvimTreeToggle<CR>", options = {desc = "toggle file tree"}})
do
    local enabled = unpack(getPackage("floatTerm"))
    if enabled then
        for ____, mode in ipairs({"n", "i", "t"}) do
            applyKeyMapping({mode = mode, inputStroke = "<A-i>", outputStroke = "<cmd>FloatermToggle __builtin_floating<CR>", options = {desc = "toggle floating terminal"}})
        end
        applyKeyMapping({mode = "t", inputStroke = "<A-h>", outputStroke = "<cmd>FloatermPrev<CR>", options = {desc = "terminal previous terminal"}})
        if not isRunningInsideTmux() then
            applyKeyMapping({
                mode = "n",
                inputStroke = "<c-b>s",
                action = function()
                    selectCustomTmuxScope()
                end,
                options = {desc = "Select custom tmux scope"}
            })
        end
        applyKeyMapping({mode = "t", inputStroke = "<A-l>", outputStroke = "<cmd>FloatermNext<CR>", options = {desc = "terminal next terminal"}})
        applyKeyMapping({mode = "t", inputStroke = "<A-n>", outputStroke = "<cmd>FloatermNew<CR>", options = {desc = "terminal new terminal"}})
        applyKeyMapping({mode = "t", inputStroke = "<A-k>", outputStroke = "<cmd>FloatermKill<CR>", options = {desc = "terminal new terminal"}})
    end
end
applyKeyMapping({mode = "t", inputStroke = "<C-x>", outputStroke = "<C-\\><C-N>", options = {desc = "terminal escape terminal mode"}})
do
    local enabled = unpack(getPackage("telescope"))
    if enabled then
        applyKeyMapping({mode = "n", inputStroke = "<leader>ff", outputStroke = "<cmd>Telescope find_files <CR>", options = {desc = "Find files"}})
        applyKeyMapping({mode = "n", inputStroke = "<leader>fw", outputStroke = "<cmd>Telescope live_grep <CR>", options = {desc = "Live grep"}})
        applyKeyMapping({mode = "n", inputStroke = "<leader>fb", outputStroke = "<cmd>Telescope buffers <CR>", options = {desc = "Find buffers"}})
        applyKeyMapping({mode = "n", inputStroke = "<leader>cm", outputStroke = "<cmd>Telescope git_commits <CR>", options = {desc = "Git commits"}})
        applyKeyMapping({mode = "n", inputStroke = "<leader>gt", outputStroke = "<cmd>Telescope git_status <CR>", options = {desc = "Git status"}})
        applyKeyMapping({mode = "n", inputStroke = "<leader>fz", outputStroke = "<cmd>Telescope current_buffer_fuzzy_find <CR>", options = {desc = "Find in current buffer"}})
    end
end
do
    local enabled = unpack(getPackage("lspConfig"))
    if enabled then
        applyKeyMapping({
            mode = "n",
            inputStroke = "<leader>fm",
            action = function()
                vim.lsp.buf.format({async = true})
            end,
            options = {desc = "LSP Formatting"}
        })
        applyKeyMapping({
            mode = "n",
            inputStroke = "<leader>,",
            action = function()
                vim.lsp.buf.signature_help()
                vim.lsp.buf.hover()
            end,
            options = {desc = "Show LSP signature & type info"}
        })
        applyKeyMapping({
            mode = "n",
            inputStroke = "<leader><c-,>",
            action = function()
                vim.diagnostic.open_float({border = "rounded"})
            end,
            options = {desc = "Show LSP signature & type info"}
        })
    end
end
do
    local enabled = unpack(getPackage("comments"))
    if enabled then
        applyKeyMapping({
            mode = "n",
            inputStroke = "<leader>/",
            action = function()
                vim.cmd("norm gcc")
            end,
            options = {desc = "toggle comment"}
        })
        applyKeyMapping({
            mode = "v",
            inputStroke = "<leader>/",
            action = function()
                vim.cmd("norm gcc")
            end,
            options = {desc = "toggle comment"}
        })
    else
        oneOffFunction(
            "warn-comments-disabled",
            function()
                vim.notify("Comments plugin is disabled", vim.log.levels.WARN)
            end
        )
    end
end
local ____opt_0 = config.packages.trouble
if ____opt_0 and ____opt_0.enabled then
    applyKeyMapping({mode = "n", inputStroke = "<leader>tdd", outputStroke = ":Trouble diagnostics toggle<CR>", options = {silent = true}})
end
if true then
    applyKeyMapping({
        mode = "n",
        inputStroke = "<F2>",
        action = function()
            vim.lsp.buf.rename()
        end,
        options = {desc = "rename"}
    })
end
local ____opt_2 = config.packages.glance
if ____opt_2 and ____opt_2.enabled then
    applyKeyMapping({mode = "n", inputStroke = "<leader>glr", outputStroke = ":Glance references<CR>", options = {desc = "Open references"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>gld", outputStroke = ":Glance definitions<CR>", options = {desc = "Open definitions"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>gltd", outputStroke = ":Glance type_definitions<CR>", options = {desc = "Open type definitions"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>gli", outputStroke = ":Glance implementations<CR>", options = {desc = "Open implementations"}})
end
if config.packages.nvimDapUI then
    applyKeyMapping({mode = "n", inputStroke = "<leader>db", outputStroke = ":DapToggleBreakpoint<CR>", options = {desc = "Toggle breakpoint"}})
    applyKeyMapping({
        mode = "n",
        inputStroke = "<leader>dr",
        action = function()
            local ____opt_4 = getGlobalConfiguration().packages.nvimTree
            if ____opt_4 and ____opt_4.enabled then
                vim.cmd("NvimTreeClose")
            end
            local ____temp_8 = vim.bo.filetype == "cs"
            if ____temp_8 then
                local ____opt_6 = getGlobalConfiguration().packages.cSharp
                ____temp_8 = ____opt_6 and ____opt_6.enabled
            end
            if ____temp_8 then
                if getDap().status() == "Running" then
                    vim.cmd("DapContinue")
                else
                    getCSharp().debug_project()
                end
            else
                vim.cmd("DapContinue")
            end
        end,
        options = {desc = "Start or continue the debugger"}
    })
    applyKeyMapping({
        mode = "n",
        inputStroke = "<leader>dt",
        action = function()
            getDapUI().toggle()
        end,
        options = {desc = "Toggle debugger UI"}
    })
    applyKeyMapping({mode = "n", inputStroke = "<leader>dsi", outputStroke = ":DapStepInto<CR>", options = {desc = "Step into"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>dso", outputStroke = ":DapStepOver<CR>", options = {desc = "Step over"}})
    applyKeyMapping({mode = "n", inputStroke = "<leader>dsO", outputStroke = ":DapStepOut<CR>", options = {desc = "Step out"}})
    applyKeyMapping({
        mode = "n",
        inputStroke = "<leader>dsc",
        action = function()
            getDap().run_to_cursor()
        end,
        options = {desc = "Step to cursor"}
    })
    applyKeyMapping({
        mode = "v",
        inputStroke = "<leader>e",
        action = function()
            getDapUI().eval()
        end,
        options = {desc = "Evaluate selected statement"}
    })
    applyKeyMapping({
        mode = "n",
        inputStroke = "<leader>e",
        action = function()
            getDapUI().eval()
        end,
        options = {desc = "Evaluate selected statement"}
    })
end
local ____opt_9 = config.packages.copilot
if ____opt_9 and ____opt_9.enabled then
    vim.keymap.set("i", "<C-J>", "copilot#Accept(\"<CR>\")", {expr = true, replace_keycodes = false})
end
local ____opt_11 = config.packages.actionsPreview
if ____opt_11 and ____opt_11.enabled then
    applyKeyMapping({
        mode = "n",
        inputStroke = ".",
        action = function()
            getActionsPreview().code_actions()
        end,
        options = {desc = "Show code actions"}
    })
end
local ____opt_13 = config.packages.lazyGit
if ____opt_13 and ____opt_13.enabled then
    applyKeyMapping({mode = "n", inputStroke = "<leader>lg", outputStroke = "<cmd>LazyGit<CR>", options = {desc = "Show code actions"}})
end
vim.cmd("map q <Nop>")
return ____exports
 end,
["lua.custom.settings.index"] = function(...) 
local ____lualib = require("lualib_bundle")
local Error = ____lualib.Error
local RangeError = ____lualib.RangeError
local ReferenceError = ____lualib.ReferenceError
local SyntaxError = ____lualib.SyntaxError
local TypeError = ____lualib.TypeError
local URIError = ____lualib.URIError
local __TS__New = ____lualib.__TS__New
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local __TS__ObjectKeys = ____lualib.__TS__ObjectKeys
local __TS__ArrayMap = ____lualib.__TS__ArrayMap
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____nui = require("lua.plugins.nui")
local useNUI = ____nui.useNUI
local function configurePlugin(pluginKey)
    local nui = useNUI()
    local configuration = getGlobalConfiguration().packages[pluginKey]
    if configuration == nil then
        error(
            __TS__New(Error, "Failed to locate plugin " .. pluginKey),
            0
        )
    end
    console.log("good")
end
local function showSettingsMenu()
    local nui = useNUI()
    local modules = __TS__ArrayMap(
        __TS__ArrayMap(
            __TS__ObjectKeys(getGlobalConfiguration().packages),
            function(____, x) return __TS__ObjectAssign(
                {},
                getGlobalConfiguration().packages[x],
                {key = x}
            ) end
        ),
        function(____, x) return nui.Menu.item(x.key, x) end
    )
    local menu = nui.Menu(
        {position = "50%", size = {width = 33, height = 10}, border = {style = "single", text = {top = "Configure Plugin"}}},
        {
            on_submit = function(item)
                if item ~= nil then
                    configurePlugin(item.key)
                end
            end,
            lines = modules
        }
    )
    menu:mount()
end
function ____exports.initCustomSettingsSystem()
    vim.api.nvim_create_user_command(
        "ShowSettings",
        function()
            showSettingsMenu()
        end,
        {}
    )
end
return ____exports
 end,
["lua.helpers.text.center"] = function(...) 
local ____exports = {}
function ____exports.centerText(input, width, spacer)
    if spacer == nil then
        spacer = " "
    end
    while #input + #spacer < width do
        input = (spacer .. input) .. spacer
    end
    return input
end
return ____exports
 end,
["lua.helpers.typed-autocmd.index"] = function(...) 
local ____exports = {}
function ____exports.useAutocmd(key, callback)
    vim.api.nvim_create_autocmd(key, {callback = callback})
end
return ____exports
 end,
["lua.helpers.window-dimensions.index"] = function(...) 
local ____exports = {}
function ____exports.actualBufferDimensions(target)
    local window = vim.fn.bufwinid(target)
    local wininfos = vim.fn.getwininfo(window)
    if wininfos == nil then
        return nil
    end
    local wininfo = wininfos[1]
    return {actualWidth = wininfo.width - wininfo.textoff}
end
return ____exports
 end,
["lua.plugins.autopairs"] = function(...) 
local ____exports = {}
local plugin = {[1] = "windwp/nvim-autopairs", event = "InsertEnter", config = true}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.barbar"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "romgrk/barbar.nvim",
    dependencies = {"lewis6991/gitsigns.nvim", "nvim-tree/nvim-web-devicons"},
    init = function()
        vim.g.barbar_auto_setup = false
    end,
    opts = {animation = true, insert_at_start = true, auto_hide = 1}
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.catppuccin"] = function(...) 
local ____exports = {}
local plugin = {[1] = "catppuccin/nvim", priority = 1000, name = "catppuccin"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.cmp"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local KIND_ICONS = {
    Text = "",
    Method = "󰆧",
    Function = "󰊕",
    Constructor = "",
    Field = "󰇽",
    Variable = "󰂡",
    Class = "󰠱",
    Interface = "",
    Module = "",
    Property = "󰜢",
    Unit = "",
    Value = "󰎠",
    Enum = "",
    Keyword = "󰌋",
    Snippet = "",
    Color = "󰏘",
    File = "󰈙",
    Reference = "",
    Folder = "󰉋",
    EnumMember = "",
    Constant = "󰏿",
    Struct = "",
    Event = "",
    Operator = "󰆕",
    TypeParameter = "󰅲"
}
function ____exports.getCMP()
    local cmp = useExternalModule("cmp")
    return cmp
end
local plugin = {
    [1] = "hrsh7th/nvim-cmp",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "neovim/nvim-lspconfig",
        "onsails/lspkind.nvim",
        "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip"
    },
    config = function()
        local cmp = ____exports.getCMP()
        cmp.setup({
            window = {completion = {winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None", col_offset = -3, side_padding = 0}},
            formatting = {format = function(_entry, vim_item)
                local target_icon = KIND_ICONS[vim_item.kind]
                local icon = target_icon or "?"
                icon = (" " .. icon) .. " "
                vim_item.menu = ("  (" .. tostring(vim_item.kind)) .. ")  "
                vim_item.kind = string.format("%s %s", icon, vim_item.kind)
                return vim_item
            end},
            snippet = {expand = function(args)
                vim.fn["vsnip#anonymous"](args.body)
            end},
            sources = cmp.config.sources({{name = "nvim_lsp"}}),
            mapping = {
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(1),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<Tab>"] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    else
                        fallback()
                    end
                end),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({select = false})
            }
        })
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.ts-context-commentstring"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.useTSContextCommentString()
    return useExternalModule("ts_context_commentstring")
end
local plugin = {
    [1] = "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
    config = function()
        ____exports.useTSContextCommentString().setup({enable_autocmd = false})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.comment"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getComments()
    return useExternalModule("Comment")
end
local plugin = {
    [1] = "numToStr/Comment.nvim",
    event = "BufRead",
    config = function()
        getComments().setup({pre_hook = useExternalModule("ts_context_commentstring.integrations.comment_nvim").create_pre_hook()})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.crates"] = function(...) 
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getCrates()
    return useExternalModule("crates")
end
local ____table_bleedingEdge_4
local ____opt_2 = getGlobalConfiguration().packages.crates
local ____opt_0 = ____opt_2 and ____opt_2.config
if ____opt_0 and ____opt_0.bleedingEdge then
    ____table_bleedingEdge_4 = nil
else
    ____table_bleedingEdge_4 = "stable"
end
local plugin = {
    [1] = "saecki/crates.nvim",
    tag = ____table_bleedingEdge_4,
    event = {"BufRead Cargo.toml"},
    config = function()
        getCrates().setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.dap-virtual-text"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useNvimDapVirtualText()
    return useExternalModule("nvim-dap-virtual-text")
end
local plugin = {
    [1] = "theHamsta/nvim-dap-virtual-text",
    event = "LspAttach",
    config = function()
        useNvimDapVirtualText().setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.dbee"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getDbee()
    return useExternalModule("dbee")
end
local plugin = {
    [1] = "kndndrj/nvim-dbee",
    dependencies = {"MunifTanjim/nui.nvim"},
    build = function()
        return getDbee().install()
    end,
    config = function()
        return getDbee().setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.diffview"] = function(...) 
local ____exports = {}
local plugin = {[1] = "sindrets/diffview.nvim", cmd = {"DiffviewOpen"}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.fidget"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useFidgetPlugin()
    return useExternalModule("fidget")
end
local plugin = {[1] = "j-hui/fidget.nvim", event = "VeryLazy", opts = {}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.firenvim"] = function(...) 
local ____exports = {}
local plugin = {[1] = "glacambre/firenvim", build = ":call firenvim#install(0)"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.flatten"] = function(...) 
local ____exports = {}
local plugin = {[1] = "willothy/flatten.nvim", config = true, lazy = false, priority = 1001}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.floatterm"] = function(...) 
local ____exports = {}
function ____exports.extendNeovimAPIWithFloattermConfig()
    return vim
end
local plugin = {[1] = "voldikss/vim-floaterm", cmd = {"FloatermNew", "FloatermToggle", "FloatermShow", "FloatermHide"}}
local nvim = ____exports.extendNeovimAPIWithFloattermConfig()
nvim.g.floaterm_title = ""
____exports.default = plugin
return ____exports
 end,
["lua.plugins.git-browse"] = function(...) 
local ____exports = {}
local plugin = {[1] = "Morozzzko/git_browse.nvim"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.glance"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "dnlhc/glance.nvim",
    config = function()
        useExternalModule("glance").setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.goto-preview"] = function(...) 
local ____exports = {}
local plugin = {[1] = "rmagatti/goto-preview", event = "BufEnter", opts = {default_mappings = true}, config = true}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.hex"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useHexPlugin()
    return useExternalModule("hex")
end
local plugin = {
    [1] = "RaafatTurki/hex.nvim",
    event = "VeryLazy",
    cmd = {"HexDump", "HexAssemble", "HexToggle"},
    config = function()
        if not vim.fn.executable("xxd") then
            vim.notify("xxd utility is required for hex editor functionality", vim.log.levels.ERROR)
            return
        end
        useHexPlugin().setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.hlchunk"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useHLChunk()
    return useExternalModule("hlchunk")
end
local plugin = {
    [1] = "shellRaining/hlchunk.nvim",
    event = {"BufReadPre", "BufNewFile"},
    config = function()
        useHLChunk().setup({chunk = {enable = true}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.icon-picker"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getIconPicker()
    return useExternalModule("icon-picker")
end
local plugin = {
    [1] = "ziontee113/icon-picker.nvim",
    event = "VeryLazy",
    config = function()
        getIconPicker().setup({disable_legacy_commands = true})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.illuminate"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getIlluminate()
    return useExternalModule("illuminate")
end
local plugin = {
    [1] = "RRethy/vim-illuminate",
    event = "BufEnter",
    config = function()
        getIlluminate().configure({delay = 100})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.indent-blankline"] = function(...) 
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "lukas-reineke/indent-blankline.nvim",
    version = "^3",
    config = function()
        local ibl = useExternalModule("ibl")
        local ____ibl_setup_3 = ibl.setup
        local ____getGlobalConfiguration_result_packages_hlchunk_enabled_2
        local ____opt_0 = getGlobalConfiguration().packages.hlchunk
        if ____opt_0 and ____opt_0.enabled then
            ____getGlobalConfiguration_result_packages_hlchunk_enabled_2 = false
        else
            ____getGlobalConfiguration_result_packages_hlchunk_enabled_2 = true
        end
        ____ibl_setup_3({scope = {enabled = ____getGlobalConfiguration_result_packages_hlchunk_enabled_2}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.kanagawa"] = function(...) 
local ____exports = {}
local plugin = {[1] = "rebelot/kanagawa.nvim", lazy = false, priority = 1000, opts = {theme = "wave", background = {dark = "dragon", light = "lotus"}}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lazygit"] = function(...) 
local ____exports = {}
local plugin = {[1] = "kdheepak/lazygit.nvim", cmd = {
    "LazyGit",
    "LazyGitConfig",
    "LazyGitCurrentFile",
    "LazyGitFilter",
    "LazyGitFilterCurrentFile"
}, dependencies = {"nvim-lua/plenary.nvim"}, keys = {{[1] = "<leader>lg", [2] = "<cmd>LazyGit<CR>"}}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.leap"] = function(...) 
local ____exports = {}
local ____keymap = require("lua.helpers.keymap.index")
local keyMappingExists = ____keymap.keyMappingExists
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getLeap()
    return useExternalModule("leap")
end
local plugin = {
    [1] = "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
        if keyMappingExists("n", "S") then
            vim.notify("Deleting conflicting mapping n::S", vim.log.levels.WARN)
            vim.keymap.del("n", "S")
        end
        if keyMappingExists("n", "s") then
            vim.notify("Deleting conflicting mapping n::s", vim.log.levels.WARN)
            vim.keymap.del("n", "s")
        end
        getLeap().create_default_mappings()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lightbulb"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getLightbulb()
    return useExternalModule("nvim-lightbulb")
end
local plugin = {
    [1] = "kosayoda/nvim-lightbulb",
    event = "BufRead",
    config = function()
        getLightbulb().setup({autocmd = {enabled = true}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lspUI"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "jinzhongjia/LspUI.nvim",
    branch = "main",
    event = "VeryLazy",
    config = function()
        local lspUI = useExternalModule("LspUI")
        lspUI.setup({inlay_hint = {enable = false}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lsp_lines"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "ErichDonGubler/lsp_lines.nvim",
    event = "VimEnter",
    config = function()
        useExternalModule("lsp_lines").setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lsp_signature"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    config = function(_, opts)
        local lsp_signature = useExternalModule("lsp_signature")
        lsp_signature.setup({always_trigger = true})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.navic"] = function(...) 
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____typed_2Dautocmd = require("lua.helpers.typed-autocmd.index")
local useAutocmd = ____typed_2Dautocmd.useAutocmd
function ____exports.getNavic()
    local ____opt_0 = getGlobalConfiguration().packages.navic
    if ____opt_0 and ____opt_0.enabled then
        return useExternalModule("nvim-navic")
    else
        return nil
    end
end
useAutocmd(
    "LspAttach",
    function(args)
        local navic = ____exports.getNavic()
        if navic then
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client.server_capabilities.documentSymbolProvider then
                navic.attach(client, args.buf)
            end
        end
    end
)
local plugin = {
    [1] = "SmiteshP/nvim-navic",
    event = "InsertEnter",
    config = function()
        ____exports.getNavic().setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lspconfig"] = function(...) 
local ____lualib = require("lualib_bundle")
local __TS__ArrayFind = ____lualib.__TS__ArrayFind
local __TS__Promise = ____lualib.__TS__Promise
local __TS__New = ____lualib.__TS__New
local __TS__AsyncAwaiter = ____lualib.__TS__AsyncAwaiter
local __TS__Await = ____lualib.__TS__Await
local __TS__ObjectAssign = ____lualib.__TS__ObjectAssign
local ____exports = {}
local getConfig, on_attach, environmentKeyToConfig, configureLSP, attachCallbacks, preHooks
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____mainLoopCallbacks = require("lua.shims.mainLoopCallbacks")
local setImmediate = ____mainLoopCallbacks.setImmediate
function getConfig()
    local config = getGlobalConfiguration()
    local lspConfigRoot = config.packages.lspconfig
    local lspConfig = lspConfigRoot.config
    return lspConfig
end
function on_attach(client, bufnr)
    local lspConfig = getConfig()
    if lspConfig.inlayHints.enabled then
        local ____error
        do
            local function ____catch(e)
                ____error = e
            end
            local ____try, ____hasReturned, ____returnValue = pcall(function()
                if client.server_capabilities.inlayHintProvider then
                    if vim.lsp.inlay_hint == nil then
                        vim.notify("Failed to enable inlay hints: neovim builtin inlay_hints unavailable", vim.log.levels.ERROR)
                    else
                        vim.lsp.inlay_hint.enable(true, {bufnr = bufnr})
                    end
                    return true
                else
                    vim.notify("Server does not support inlay hints")
                end
            end)
            if not ____try then
                ____hasReturned, ____returnValue = ____catch(____hasReturned)
            end
            if ____hasReturned then
                return ____returnValue
            end
        end
        vim.notify("Failed to enable LSP hints: " .. tostring(____error))
    end
    for ____, callback in ipairs(attachCallbacks) do
        callback(client, bufnr)
    end
end
function ____exports.getLSPConfig()
    local lspconfig = useExternalModule("lspconfig")
    return lspconfig
end
function environmentKeyToConfig(env)
    local configs = {
        {
            key = "typescript",
            lspKey = "ts_ls",
            required_executable = "typescript-language-server",
            additionalOptions = {
                single_file_support = false,
                root_dir = ____exports.getLSPConfig().util.root_pattern("package.json")
            }
        },
        {
            key = "deno",
            lspKey = "denols",
            additionalOptions = {root_dir = ____exports.getLSPConfig().util.root_pattern("deno.json", "deno.jsonc")}
        },
        {key = "c/c++", lspKey = "clangd"},
        {key = "markdown", lspKey = "marksman"},
        {key = "lua", lspKey = "lua_ls"},
        {key = "yaml", lspKey = "yamlls", required_executable = "yaml-language-server"},
        {key = "rust", lspKey = "rust_analyzer"},
        {key = "bash", lspKey = "bashls"}
    }
    return __TS__ArrayFind(
        configs,
        function(____, x) return x.key == env end
    )
end
function configureLSP()
    return __TS__AsyncAwaiter(function(____awaiter_resolve)
        __TS__Await(__TS__New(
            __TS__Promise,
            function(____, resolve) return setImmediate(resolve) end
        ))
        local lspconfig = ____exports.getLSPConfig()
        local targetEnvironments = getGlobalConfiguration().targetEnvironments
        for targetEnvKey in pairs(targetEnvironments) do
            do
                local ____opt_0 = targetEnvironments[targetEnvKey]
                if not (____opt_0 and ____opt_0.enabled) then
                    goto __continue29
                end
                local config = environmentKeyToConfig(targetEnvKey)
                if config == nil then
                    vim.notify("Failed to locate configuration for environment " .. targetEnvKey, vim.log.levels.WARN)
                else
                    if config.required_executable ~= nil then
                        if vim.fn.executable(config.required_executable) ~= 1 then
                            vim.notify(((("Cannot enable LSP server <" .. config.key) .. ">: required executable '") .. config.required_executable) .. "' is not present.", vim.log.levels.WARN)
                            goto __continue29
                        end
                    end
                    local capabilities = vim.lsp.protocol.make_client_capabilities()
                    local ____opt_2 = getGlobalConfiguration().packages.cmp
                    if ____opt_2 and ____opt_2.enabled then
                        local cmp_capabilities = useExternalModule("cmp_nvim_lsp").default_capabilities()
                        capabilities = __TS__ObjectAssign({}, capabilities, cmp_capabilities)
                    end
                    local ____config_additionalOptions_4 = config.additionalOptions
                    if ____config_additionalOptions_4 == nil then
                        ____config_additionalOptions_4 = {}
                    end
                    local setupConfig = __TS__ObjectAssign({}, ____config_additionalOptions_4, {capabilities = capabilities, on_attach = on_attach})
                    for ____, preHook in ipairs(preHooks) do
                        preHook(config.lspKey, setupConfig)
                    end
                    lspconfig[config.lspKey].setup(setupConfig)
                end
            end
            ::__continue29::
        end
        local ____vim_diagnostic_config_8 = vim.diagnostic.config
        local ____opt_5 = getGlobalConfiguration().packages.lspLines
        local ____temp_7 = ____opt_5 and ____opt_5.enabled
        if ____temp_7 == nil then
            ____temp_7 = false
        end
        ____vim_diagnostic_config_8({update_in_insert = true, virtual_text = not ____temp_7})
    end)
end
local plugin = {[1] = "neovim/nvim-lspconfig", config = configureLSP}
attachCallbacks = {}
preHooks = {}
function ____exports.registerLSPServerAttachCallback(callback)
    attachCallbacks[#attachCallbacks + 1] = callback
    configureLSP()
end
function ____exports.registerLSPConfigurationHook(hook)
    preHooks[#preHooks + 1] = hook
    configureLSP()
end
do
    local lspConfig = getConfig()
    if lspConfig.inlayHints.enabled then
        if lspConfig.inlayHints.displayMode ~= "always" then
            vim.api.nvim_create_autocmd(
                "InsertEnter",
                {callback = function()
                    if lspConfig.inlayHints.displayMode == "only-in-normal-mode" then
                        vim.lsp.inlay_hint.enable(false)
                    end
                end}
            )
        end
        vim.api.nvim_create_autocmd(
            "InsertLeave",
            {callback = function()
                if lspConfig.inlayHints.displayMode == "only-in-normal-mode" or lspConfig.inlayHints.displayMode == "always" then
                    vim.lsp.inlay_hint.enable(true)
                end
            end}
        )
    end
end
local function getPluginConfig()
    local config = getGlobalConfiguration()
    return config.packages.lspconfig
end
vim.api.nvim_create_autocmd(
    "LspAttach",
    {callback = function(_args)
        local args = _args
    end}
)
____exports.default = plugin
return ____exports
 end,
["lua.plugins.lualine"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____theme = require("lua.theme")
local globalThemeType = ____theme.globalThemeType
local onThemeChange = ____theme.onThemeChange
local ____navic = require("lua.plugins.navic")
local getNavic = ____navic.getNavic
local plugin = {
    [1] = "nvim-lualine/lualine.nvim",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
        local module = useExternalModule("lualine")
        local function createStandardComponent(____type)
            local result = {}
            result[1] = ____type
            return ____type
        end
        local function createCustomComponent(func)
            local result = {}
            result.fmt = function(input) return input end
            result[1] = func
            return result
        end
        local function genConfig()
            local config = {
                options = {theme = globalThemeType() == "dark" and "material" or "ayu_light"},
                sections = {
                    lualine_b = {
                        createStandardComponent("branch"),
                        createStandardComponent("diff"),
                        createStandardComponent("diagnostics")
                    },
                    lualine_c = {
                        createCustomComponent(function() return "PID: " .. tostring(vim.fn.getpid()) end),
                        createCustomComponent(function()
                            local navic = getNavic()
                            if navic == nil then
                                return " Navic Disabled"
                            else
                                if navic.is_available() then
                                    return navic.get_location()
                                else
                                    return "󱈸 Scope Info Unavailable"
                                end
                            end
                        end)
                    }
                }
            }
            return config
        end
        onThemeChange(function(____type)
            module.setup(genConfig())
        end)
        module.setup(genConfig())
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.markdown-preview"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "iamcco/markdown-preview.nvim",
    cmd = {"MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop"},
    build = "cd app && npm install",
    init = function()
        vim.g.mkdp_filetypes = {"markdown"}
    end,
    ft = {"markdown"}
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.marks"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "chentoast/marks.nvim",
    config = function()
        local target = "marks"
        useExternalModule(target).setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.markview"] = function(...) 
local ____exports = {}
local plugin = {[1] = "OXY2DEV/markview.nvim", lazy = false, dependencies = {"nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons"}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.mason-nvim-dap"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.getMasonNvimDap()
    return useExternalModule("mason-nvim-dap")
end
local plugin = {
    [1] = "jay-babu/mason-nvim-dap.nvim",
    event = "InsertEnter",
    dependencies = {"williamboman/mason.nvim", "mfussenegger/nvim-dap"},
    config = function()
        ____exports.getMasonNvimDap().setup({ensure_installed = {
            "node2",
            "firefox",
            "cppdbg",
            "js",
            "codelldb"
        }})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.mason"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "williamboman/mason.nvim",
    config = function()
        useExternalModule("mason").setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.neogen"] = function(...) 
local ____exports = {}
local plugin = {[1] = "danymat/neogen", config = true}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.neotest"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.useNeotest()
    return useExternalModule("neotest")
end
local plugin = {[1] = "nvim-neotest/neotest", dependencies = {"nvim-neotest/nvim-nio", "nvim-lua/plenary.nvim", "antoinemadec/FixCursorHold.nvim", "nvim-treesitter/nvim-treesitter"}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.noice"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getNoice()
    local noice = useExternalModule("noice")
    return noice
end
local plugin = {
    [1] = "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"},
    config = function()
        if vim.g.started_by_firenvim then
        else
            local noice = getNoice()
            noice.setup({})
        end
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nord"] = function(...) 
local ____exports = {}
local plugin = {[1] = "shaunsingh/nord.nvim", lazy = false, priority = 1000}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nvim-notify"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getNvimNotify()
    local noice = useExternalModule("notify")
    return noice
end
local plugin = {
    [1] = "rcarriga/nvim-notify",
    event = "VeryLazy",
    dependencies = {"MunifTanjim/nui.nvim", "rcarriga/nvim-notify"},
    config = function()
        if vim.g.started_by_firenvim then
        else
            local notify = getNvimNotify()
            notify.setup({})
            vim.notify = notify
        end
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nvim-tree-devicons"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "nvim-tree/nvim-web-devicons",
    config = function()
        local module = useExternalModule("nvim-web-devicons")
        module.setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.nvim-tree"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "nvim-tree/nvim-tree.lua",
    cmd = {"NvimTreeToggle", "NvimTreeFocus"},
    opts = function()
        local options = {
            filters = {
                dotfiles = false,
                exclude = {vim.fn.stdpath("config") .. "/lua/custom"}
            },
            disable_netrw = true,
            hijack_netrw = true,
            hijack_cursor = true,
            hijack_unnamed_buffer_when_opening = false,
            sync_root_with_cwd = true,
            update_focused_file = {enable = true, update_root = false},
            view = {adaptive_size = false, side = "left", width = 30, preserve_window_proportions = true},
            git = {enable = false, ignore = true},
            filesystem_watchers = {enable = true},
            actions = {open_file = {resize_window = true}},
            renderer = {
                root_folder_label = false,
                highlight_git = false,
                highlight_opened_files = "none",
                indent_markers = {enable = false},
                icons = {show = {file = true, folder = true, folder_arrow = true, git = false}, glyphs = {default = "󰈚", symlink = "", folder = {
                    default = "",
                    empty = "",
                    empty_open = "",
                    open = "",
                    symlink = "",
                    symlink_open = "",
                    arrow_open = "",
                    arrow_closed = ""
                }, git = {
                    unstaged = "✗",
                    staged = "✓",
                    unmerged = "",
                    renamed = "➜",
                    untracked = "★",
                    deleted = "",
                    ignored = "◌"
                }}}
            }
        }
        return options
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.obsidian"] = function(...) 
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____temp_4 = {"markdown"}
local ____temp_5 = {"nvim-lua/plenary.nvim"}
local ____opt_2 = getGlobalConfiguration().packages.obsidian
local ____opt_0 = ____opt_2 and ____opt_2.config
local plugin = {
    [1] = "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = ____temp_4,
    dependencies = ____temp_5,
    opts = {workspaces = ____opt_0 and ____opt_0.workspaces or ({})}
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.octo"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    event = "VeryLazy",
    cmd = {"Octo"},
    [1] = "pwntester/octo.nvim",
    dependencies = {"nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim", "nvim-tree/nvim-web-devicons"},
    config = function()
        useExternalModule("octo").setup()
        vim.treesitter.language.register("markdown", "octo")
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.outline"] = function(...) 
local ____exports = {}
local plugin = {
    [1] = "hedyhli/outline.nvim",
    lazy = true,
    cmd = {"Outline", "OutlineOpen"},
    keys = {{[1] = "<leader>o", [2] = "<cmd>Outline<CR>", desc = "Toggle outline"}},
    opts = {symbol_folding = {}, preview_window = {auto_preview = true, live = true}, outline_items = {show_symbol_lineno = true}}
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.overseer"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useOverseer()
    return useExternalModule("overseer")
end
local plugin = {
    [1] = "stevearc/overseer.nvim",
    opts = {},
    config = function()
        useOverseer().setup()
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.rainbow-delimiters"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
        useExternalModule("rainbow-delimiters.setup").setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.rest"] = function(...) 
local ____exports = {}
local plugin = {[1] = "rest-nvim/rest.nvim"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.rustaceanvim"] = function(...) 
local ____exports = {}
function ____exports.getRustaceonVimExtendedVIMApi()
    return vim
end
local plugin = {
    [1] = "mrcjkb/rustaceanvim",
    version = "^5",
    ft = {"rust"},
    dependencies = {"nvim-lua/plenary.nvim", "mfussenegger/nvim-dap"},
    config = function()
        local vim = ____exports.getRustaceonVimExtendedVIMApi()
        vim.g.rustaceanvim = {tools = {hover_actions = {auto_focus = false, replace_builtin_hover = false}}}
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.screenkey"] = function(...) 
local ____exports = {}
local plugin = {[1] = "NStefan002/screenkey.nvim", lazy = false, version = "*"}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.surround"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "kylechui/nvim-surround",
    version = "*",
    event = {"VeryLazy", "InsertEnter"},
    config = function()
        useExternalModule("nvim-surround").setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.symbol-usage"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function textFormat(symbol)
    local result = {}
    local roundStart = {"", "SymbolUsageRounding"}
    local roundEnd = {"", "SymbolUsageRounding"}
    local stackedFunctionsContent = symbol.stacked_count > 0 and tostring(symbol.stacked_count) or ""
    if symbol.references ~= nil then
        local usage = symbol.references <= 1 and "reference" or "references"
        local num = symbol.references == 0 and "no" or symbol.references
        result[#result + 1] = roundStart
        result[#result + 1] = {"󰌹 ", "SymbolUsageRef"}
        result[#result + 1] = {
            (tostring(num) .. " ") .. usage,
            "SymbolUsageContent"
        }
        result[#result + 1] = roundEnd
    end
    if symbol.definition then
        if #result > 0 then
            result[#result + 1] = {" ", "NonText"}
        end
        result[#result + 1] = roundStart
        result[#result + 1] = {"󰳽 ", "SymbolUsageDef"}
        result[#result + 1] = {
            tostring(symbol.definition) .. " defs",
            "SymbolUsageContent"
        }
        result[#result + 1] = roundEnd
    end
    if symbol.implementation then
        if #result > 0 then
            result[#result + 1] = {" ", "NonText"}
        end
        result[#result + 1] = roundStart
        result[#result + 1] = {"󰡱 ", "SymbolUsageImpl"}
        result[#result + 1] = {
            tostring(symbol.implementation) .. " impls",
            "SymbolUsageContent"
        }
        result[#result + 1] = roundEnd
    end
    if #stackedFunctionsContent > 0 then
        if #result > 0 then
            result[#result + 1] = {" ", "NonText"}
        end
        result[#result + 1] = roundStart
        result[#result + 1] = {" ", "SymbolUsageImpl"}
        result[#result + 1] = {stackedFunctionsContent, "SymbolUsageContent"}
        result[#result + 1] = roundEnd
    end
    return result
end
local plugin = {
    [1] = "Wansmer/symbol-usage.nvim",
    event = "LspAttach",
    config = function()
        useExternalModule("symbol-usage").setup({text_format = textFormat})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.telescope-import"] = function(...) 
local ____exports = {}
local plugin = {[1] = "piersolenski/telescope-import.nvim", dependencies = {"nvim-telescope/telescope.nvim"}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.telescope"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
function ____exports.getTelescope()
    return useExternalModule("telescope")
end
local plugin = {
    [1] = "nvim-telescope/telescope.nvim",
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
        ____exports.getTelescope().setup({extensions = {["ui-select"] = {useExternalModule("telescope.themes").get_dropdown({})}}})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.telescope-ui-select"] = function(...) 
local ____exports = {}
local ____telescope = require("lua.plugins.telescope")
local getTelescope = ____telescope.getTelescope
local plugin = {
    [1] = "nvim-telescope/telescope-ui-select.nvim",
    event = "VimEnter",
    config = function()
        getTelescope().load_extension("ui-select")
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.theme-flow"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "0xstepit/flow.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
        useExternalModule("flow").setup({
            dark_theme = true,
            high_contrast = false,
            transparent = true,
            fluo_color = "pink",
            mode = "base",
            aggressive_spell = false
        })
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.time-tracker"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "3rd/time-tracker.nvim",
    dependencies = {"3rd/sqlite.nvim"},
    event = "VeryLazy",
    cmd = {"TimeTracker"},
    config = function()
        useExternalModule("time-tracker").setup({
            data_file = vim.fn.stdpath("data") .. "/time-tracker.db",
            tracking_events = {
                "BufEnter",
                "BufWinEnter",
                "CursorMoved",
                "CursorMovedI",
                "WinScrolled"
            },
            tracking_timeout_seconds = 5 * 1000
        })
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.tiny-inline-diagnostic"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useTinyInlineDiagnostic()
    return useExternalModule("tiny-inline-diagnostic")
end
local plugin = {
    [1] = "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
        useTinyInlineDiagnostic().setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.todo-comments"] = function(...) 
local ____exports = {}
local plugin = {[1] = "folke/todo-comments.nvim", dependencies = {"nvim-lua/plenary.nvim"}, opts = {}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.tokyonight"] = function(...) 
local ____exports = {}
local plugin = {[1] = "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.treesitter-context"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function useTreeSitterContextPlugin()
    return useExternalModule("treesitter-context")
end
local plugin = {
    [1] = "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    config = function()
        useTreeSitterContextPlugin().setup({enabled = true, max_lines = 2, trim_scope = "inner"})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.treesitter"] = function(...) 
local ____exports = {}
local ____configuration = require("lua.helpers.configuration.index")
local getGlobalConfiguration = ____configuration.getGlobalConfiguration
local ____getGlobalConfiguration_result_packages_tsAutoTag_enabled_2
local ____opt_0 = getGlobalConfiguration().packages.tsAutoTag
if ____opt_0 and ____opt_0.enabled then
    ____getGlobalConfiguration_result_packages_tsAutoTag_enabled_2 = true
else
    ____getGlobalConfiguration_result_packages_tsAutoTag_enabled_2 = nil
end
local plugin = {[1] = "nvim-treesitter/nvim-treesitter", opts = {autotag = {enable = ____getGlobalConfiguration_result_packages_tsAutoTag_enabled_2}}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.treesj"] = function(...) 
local ____exports = {}
local ____keymap = require("lua.helpers.keymap.index")
local applyKeyMapping = ____keymap.applyKeyMapping
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getTreesj()
    return useExternalModule("treesj")
end
local plugin = {
    [1] = "Wansmer/treesj",
    keys = {"<space>j"},
    dependencies = {"nvim-treesitter/nvim-treesitter"},
    config = function()
        applyKeyMapping({
            mode = "n",
            inputStroke = "<leader>j",
            action = function()
                getTreesj().toggle()
            end,
            options = {}
        })
        return getTreesj().setup({use_default_keymaps = false, max_join_length = 4096})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.trouble"] = function(...) 
local ____exports = {}
local plugin = {[1] = "folke/trouble.nvim", cmd = {"Trouble"}, opts = {}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.ts-autotag"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local plugin = {
    [1] = "windwp/nvim-ts-autotag",
    event = "VimEnter",
    config = function()
        useExternalModule("nvim-ts-autotag").setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.ufo"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local ____lspconfig = require("lua.plugins.lspconfig")
local registerLSPConfigurationHook = ____lspconfig.registerLSPConfigurationHook
local plugin = {
    [1] = "kevinhwang91/nvim-ufo",
    dependencies = {"kevinhwang91/promise-async"},
    event = "VeryLazy",
    config = function()
        vim.o.foldcolumn = "0"
        vim.o.foldlevel = 99
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {dynamicRegistration = false, lineFoldingOnly = true}
        registerLSPConfigurationHook(function(key, config)
            config.capabilities.textDocument.foldingRange = {dynamicRegistration = false, lineFoldingOnly = true}
        end)
        useExternalModule("ufo").setup({})
    end
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.ultimate-autopair"] = function(...) 
local ____exports = {}
local plugin = {[1] = "altermo/ultimate-autopair.nvim", event = {"InsertEnter", "CmdlineEnter"}, opts = {bs = {space = "balance"}, cr = {autoclose = true}}}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.undotree"] = function(...) 
local ____exports = {}
local ____useModule = require("lua.helpers.module.useModule")
local useExternalModule = ____useModule.useExternalModule
local function getUndoTree()
    return useExternalModule("undotree")
end
local plugin = {
    [1] = "jiaoshijie/undotree",
    config = function()
        getUndoTree().setup()
        vim.api.nvim_create_user_command(
            "UndoTreeToggle",
            function()
                getUndoTree().toggle()
            end,
            {}
        )
        vim.api.nvim_create_user_command(
            "UndoTreeOpen",
            function()
                getUndoTree().open()
            end,
            {}
        )
        vim.api.nvim_create_user_command(
            "UndoTreeClose",
            function()
                getUndoTree().close()
            end,
            {}
        )
    end,
    dependencies = {"nvim-lua/plenary.nvim"}
}
____exports.default = plugin
return ____exports
 end,
["lua.plugins.wakatime"] = function(...) 
local ____exports = {}
local plugin = {[1] = "wakatime/vim-wakatime", lazy = false}
____exports.default = plugin
return ____exports
 end,
}
return require("main", ...)
